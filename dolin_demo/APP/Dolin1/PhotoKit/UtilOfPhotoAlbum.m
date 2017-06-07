//
//  UtilOfPhotoAlbum.m
//  dolin_demo
//
//  Created by dolin on 2017/6/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "UtilOfPhotoAlbum.h"

// 不建议设置太大，太大的话会导致图片加载过慢
#define kMaxImageWidth 500

@implementation UtilOfPhotoAlbum

SINGLETON_FOR_IMPLEMENTATION(UtilOfPhotoAlbum)

- (NSArray<ModelPhotoAlbum *> *)getPhotoAblumList {
    // 最终需要的ModelPhotoAlbum泛型数组
    NSMutableArray<ModelPhotoAlbum *> *photoAblumList = [NSMutableArray array];
    
    // 获取所有智能相册（经由相机得来的相册）
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        // 过滤掉最近删除 与 最近添加
        if(collection.assetCollectionSubtype < 212 && collection.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumRecentlyAdded) {
            NSArray<PHAsset *> *assets = [self getAssetsInAssetCollection:collection ascending:NO];
            if (assets.count > 0) {
                ModelPhotoAlbum *model = [[ModelPhotoAlbum alloc] init];
                model.title = collection.localizedTitle;
                model.count = assets.count;
                model.headImageAsset = assets.firstObject;
                model.assetCollection = collection;
                [photoAblumList addObject:model];
            }
        }
    }];
    
    // 获取用户创建的相册（从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册）
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<PHAsset *> *assets = [self getAssetsInAssetCollection:collection ascending:NO];
        if (assets.count > 0) {
            ModelPhotoAlbum *model = [[ModelPhotoAlbum alloc] init];
            model.title = collection.localizedTitle;
            model.count = assets.count;
            model.headImageAsset = assets.firstObject;
            model.assetCollection = collection;
            [photoAblumList addObject:model];
        }
    }];
    
    return photoAblumList;
}

// 获取指定相册内的所有图片、视频
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    NSMutableArray<PHAsset *> *arr = [NSMutableArray array];
    
    PHFetchResult *result = [self fetchAssetsInAssetCollection:assetCollection ascending:ascending];
    [result enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 再次过滤(这里目前只要照片)
        // || obj.mediaType == PHAssetMediaTypeVideo
        if (obj.mediaType == PHAssetMediaTypeImage) {
            [arr addObject:obj];
        }
    }];
    return arr;
}

// 按时间升序或者降序排列
- (PHFetchResult *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return result;
}

- (void)requestImageForAsset:(PHAsset *)asset
                        size:(CGSize)size
                  completion:(void (^)(UIImage *image, NSDictionary *info))completion {
    // ☆☆☆ 重点 ☆☆☆
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    
    // 剪裁参数 如果两个地方所控制的剪裁结果有所冲突，PhotoKit 会以resizeMode 的结果为准
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    // 控制是否允许网络请求，默认为 NO,拉取不到 iCloud 的图像原件
    option.networkAccessAllowed = NO;
    
    // 如果synchronous为 YES，即同步请求时，deliveryMode 会被视为PHImageRequestOptionsDeliveryModeHighQualityForma
    option.synchronous = NO;
    
    // 控制请求的图片质量
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // 与 iCloud 密切相关的属性 resultHandler被调用多次的原因
    option.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
    };
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        // 排除取消，错误的情况
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey];
        if (downloadFinined && completion) {
            completion(image, info);
        }
    }];
}

- (void)saveImageToAblum:(UIImage *)image completion:(void (^)(BOOL, PHAsset *))completion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO, nil);
    } else if (status == PHAuthorizationStatusRestricted) {
        if (completion) completion(NO, nil);
    } else {
        __block PHObjectPlaceholder *placeholderAsset=nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *newAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                if (completion) completion(NO, nil);
                return;
            }
            PHAsset *asset = [self getAssetFromlocalIdentifier:placeholderAsset.localIdentifier];
            PHAssetCollection *desCollection = [self getDestinationCollection];
            if (!desCollection) completion(NO, nil);
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:desCollection] addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (completion) completion(success, asset);
            }];
        }];
    }
}


/**
 根据localIdentifier获取PHAsset

 @param localIdentifier
 @return 
 */
- (PHAsset *)getAssetFromlocalIdentifier:(NSString *)localIdentifier{
    if(localIdentifier == nil){
        NSLog(@"Cannot get asset from localID because it is nil");
        return nil;
    }
    PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil];
    if(result.count){
        return result[0];
    }
    return nil;
}

/**
 获取以APP名为名的相册

 @return
 */
- (PHAssetCollection *)getDestinationCollection
{
    // 先判断是否已经有自定义相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:APP_NAME]) {
            return collection;
        }
    }
    
    // 没有自定义的相册就创建
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:APP_NAME].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        NSLog(@"创建相册：%@失败", APP_NAME);
        return nil;
    }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}


@end

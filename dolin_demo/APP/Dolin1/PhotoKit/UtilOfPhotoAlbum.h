//
//  UtilOfPhotoAlbum.h
//  dolin_demo
//
//  Created by dolin on 2017/6/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "ModelPhotoAlbum.h"

// TODO：扩充更多漂亮的API

/**
 相册工具类
 */
@interface UtilOfPhotoAlbum : NSObject

/**
 快速单例
 */
SINGLETON_FOR_HEADER(UtilOfPhotoAlbum);

/**
 获取所有相册列表
 */
- (NSArray<ModelPhotoAlbum *> *)getPhotoAblumList;

/**
 获取每个Asset对应的图片

 @param asset
 @param size
 @param completion
 */
- (void)requestImageForAsset:(PHAsset *)asset
                        size:(CGSize)size
                  completion:(void (^)(UIImage *image, NSDictionary *info))completion
              iCloudProgress:(void (^)(double ))iCloudProgress;

// 上面方法的重载
- (void)requestImageForAsset:(PHAsset *)asset
                        size:(CGSize)size
                  completion:(void (^)(UIImage *image, NSDictionary *info))completion;

/**
 保存图片到以APP名为名的自定义相册
 
 @param image
 @param completion
*/
- (void)saveImageToAblum:(UIImage *)image
              completion:(void (^)(BOOL, PHAsset *))completion;


/**
 获取指定相册内的所有图片、视频

 @param assetCollection
 @param ascending
 @return    
 */
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                         ascending:(BOOL)ascending;


@end

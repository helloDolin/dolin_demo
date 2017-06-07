//
//  DLPhotoBrowser.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ModelSelectedAsset.h"
@class PhotoBrowserCell;

@protocol DLPhotoBrowserDelegate <NSObject>
- (void)selectedAssets:(NSMutableArray<ModelSelectedAsset*>*)selectedAssets
        isClickNextBtn:(BOOL)isClickNextBtn;
@end

@interface DLPhotoBrowser : UIView

@property(nonatomic,weak) id<DLPhotoBrowserDelegate> delegate;
@property (nonatomic, strong) UICollectionView* collectionView;

+ (DLPhotoBrowser *)dLPhotoBrowserWithData:(NSMutableArray<PHAsset *> *)arrayDataSources
                            targetImageIndex:(NSInteger)targetImageIndex
                              selectedAssets:(NSMutableArray<ModelSelectedAsset *>*) selectedAssets
                            maxSelectedCount:(NSInteger)maxSelectedCount;

- (void)renderCellWithHighQuality2Cell:(PhotoBrowserCell*)cell;
@end

//
//  DLPhotoBrowserVC.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/27.
//  Copyright © 2017年 boqii. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DLPhotoBrowser.h"

@protocol DLPhotoBrowserVCDelegate <NSObject>

- (void)selectedAssets:(NSMutableArray<ModelSelectedAsset*>*)selectedAssets
        isClickNextBtn:(BOOL)isClickNextBtn;

@end

/**
 页面描述：
 */
@interface DLPhotoBrowserVC : UIViewController

@property (nonatomic, weak) id<DLPhotoBrowserVCDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<PHAsset *> * arrayDataSources;
@property (nonatomic, assign) NSInteger targetImageIndex;
@property (nonatomic, strong) NSMutableArray<ModelSelectedAsset *>* selectedAssets;
@property (nonatomic, assign) NSInteger maxSelectedCount;

@end

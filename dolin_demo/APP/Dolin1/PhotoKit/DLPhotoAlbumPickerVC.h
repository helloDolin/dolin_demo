//
//  DLPhotoAlbumPickerVC.h
//  dolin_demo
//
//  Created by dolin on 2017/6/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelSelectedAsset.h"

/**
 照片选取器
 */
@interface DLPhotoAlbumPickerVC : UIViewController

@property (nonatomic, strong) NSMutableArray<ModelSelectedAsset *> *selectedAssets;
@property (nonatomic, assign) NSInteger maxSelectedCount;

@end

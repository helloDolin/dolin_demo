//
//  ModelSelectedAsset.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/**
 被选中的asset
 */
@interface ModelSelectedAsset : NSObject

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, copy) NSString *localIdentifier;

@end

//
//  DolinTabBarController.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DLTabModel.h"

#import <UIKit/UIKit.h>

@interface DolinTabBarController : UIViewController

+ (instancetype)sharedInstance;

/// 切换 rootVC 调用
/// @param hasScanAuthority 有权限，中间按钮显示
- (void)loadElectricHomeVC:(BOOL)hasScanAuthority;

@end

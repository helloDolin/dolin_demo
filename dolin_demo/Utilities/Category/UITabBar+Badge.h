//
//  UITabBar+Badge.h
//  Maxer
//
//  Created by Yanci on 15/12/12.
//  Copyright © 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index; //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end

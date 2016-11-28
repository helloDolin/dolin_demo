//
//  UIWindow+Expand.m
//  dolin_demo
//
//  Created by shaolin on 16/7/14.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "UIWindow+Expand.h"
#import "LaunchViewController.h"

@implementation UIWindow (Expand)

- (void)showLanuchPageAndSetSomeOthers {
    LaunchViewController *aunchViewController = [[LaunchViewController alloc] init];
    [self addSubview:aunchViewController.view];
}

@end

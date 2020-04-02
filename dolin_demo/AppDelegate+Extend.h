//
//  AppDelegate+Extend.h
//  dolin_demo
//
//  Created by dolin999 on 2020/3/30.
//  Copyright © 2020 shaolin. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// AppDelegate 扩展 (分离出 setup 相关)
@interface AppDelegate (Extend)

- (void)setupFlutter;
- (void)setupWindow;
- (void)setupLocalNotification:(UIApplication*)application;
- (void)setupAudioPlayBack;
- (void)setupDoraemonKit;
- (void)setup3DTouch;

@end

NS_ASSUME_NONNULL_END

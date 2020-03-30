//
//  AppDelegate.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Extend.h"
#import "AddNoteViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupFlutter];
    [self setupWindow];
    [self setupLocalNotification:application];
    [self setupAudioPlayBack];
    [self setupJSPatch];
    [self setupDoraemonKit];
    [self setup3DTouch];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 进入前台，清空 badge num
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification {
    // 监听本地推送通知
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertTitle message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 监听远程推送通知
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 将 deviceToken 交给某方保存，如：JSPatch
    // 把deviceToken设备令牌发送给服务器，时刻保持deviceToken是最新的
    NSString* tokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    NSLog(@"Device Token:%@", tokenStr);
} 

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0) {
    NSLog(@"APNs 注册失败：%@", error);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.absoluteString hasPrefix:@"todaywidget"]) {
        // 判断是否是直接跳入到添加页面
        if ([url.absoluteString hasSuffix:@"add"]) {
            UITabBarController *tabVC = (UITabBarController*)self.window.rootViewController;
            UINavigationController *nav = (UINavigationController *)tabVC.viewControllers[0];
            AddNoteViewController* addVC = [AddNoteViewController new];
            [nav pushViewController:addVC animated:YES];
        }
    }
    return YES;
}

@end

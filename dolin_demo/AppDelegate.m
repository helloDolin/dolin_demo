//
//  AppDelegate.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AppDelegate.h"
#import "DolinTabBarController.h"
#import "UIWindow+Expand.h"
#import <AVFoundation/AVFoundation.h>
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -  method 
- (void)setUpBadgeNum:(UIApplication*)application {
    application.applicationIconBadgeNumber = 0;
}

- (void)setUpWindow {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.window.backgroundColor = [UIColor whiteColor];
    DolinTabBarController* dolinTabBarController = [[DolinTabBarController alloc]init];
    self.window.rootViewController = dolinTabBarController;
    [self.window makeKeyAndVisible];
    
    // 这行代码需放到makeKeyAndVisible之后且window需要自行初始化
    [self.window showLanuchPageAndSetSomeOthers];
}

- (void)setUpLocalNotification:(UIApplication*)application {
    // 在iOS 8.0之后如果要使用本地通知，需要得到用户的许可;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert categories:nil];
        // 注册用户是否需要通知内容
        [application registerUserNotificationSettings:setting];
    }

}

- (void)setUpAudioPlayBack {
    // 让音乐可以在后台播放
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
}

- (void)setUpOthers {
    // 测试JSPatch
    [JSPatch testScriptInBundle];
}

#pragma mark -  UIApplicationDelegate 
// 对于应用程序初始化，强烈建议您使用此方法和应用程序
// 如果应用程序无法处理URL资源或继续用户活动，则返回NO，否则返回YES。如果应用程序由于远程通知而启动，则会忽略返回值。
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setUpBadgeNum:application];
    [self setUpWindow];
    [self setUpLocalNotification:application];
    [self setUpAudioPlayBack];
    [self setUpOthers];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    Xcode8开始，不需要写代码控制了，在TARGETS -> AppName -> Capabilities中可视化配置
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification {
    NSDictionary * dic = notification.userInfo;
    NSLog(@"%@",dic);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
}

@end

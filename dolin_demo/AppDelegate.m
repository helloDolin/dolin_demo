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
#import "AddNoteViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -  method

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
//    开始本地推送通知：
//    第一种方法，延时推送，根据本地通知对象的fireDate设置进行本地推送通知
//    
//    [[UIApplication shareApplication] scheduleLocalNotification:notification];
//    第二种方法，立刻推送，忽略本地通知对象的fireDate设置进行本地推送通知
//    
//    [[UIApplication shareApplication] presentLocalNotificationNow:notification];
    
    
    UILocalNotification *notification = [self makeLocalNotification];
    [application scheduleLocalNotification:notification];
    
    
    // 在iOS 8.0之后如果要使用本地通知、远程通知，需要得到用户的许可;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert categories:nil];
        // 注册用户是否需要通知内容
        [application registerUserNotificationSettings:setting];
    }

}
- (UILocalNotification *)makeLocalNotification{
    // 重点 先取消掉上一次的全部notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 创建本地推送通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    NSDate *resDate = [formatter dateFromString:@"2017-05-16 14-06-00"];
    // 设定为明天中午12点触发通知
    notification.fireDate = resDate;
    // 记得设置当前时区，没有设置的话，fireDate将不考虑时区，这样的通知会不准确
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 每隔一天触发一次
    notification.repeatInterval = NSCalendarUnitDay;
    //设置通知属性
    notification.alertBody = @"go to eat";// 通知主体
    notification.applicationIconBadgeNumber = 1; // 应用程序图标右上角显示的消息数
    notification.alertAction = @"打开应用";  // 待机界面的滑动动作提示
    notification.alertLaunchImage = @"Default"; // 通过点击通知打开应用时的启动图片,这里使用程序启动图片
    notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    //设置用户信息
    notification.userInfo = @{
                               @"user":@"dolin",
                               @"msg":@"eat"
                               }; // 绑定到通知上的其他附加信息
    
    return notification;
}

- (void)setUpAudioPlayBack {
    // 让音乐可以在后台播放
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
}

- (void)setUpJSPatch {
    // 测试JSPatch
    [JSPatch testScriptInBundle];
}

#pragma mark -  UIApplicationDelegate 
// 对于应用程序初始化，强烈建议您使用此方法和应用程序
// 如果应用程序无法处理URL资源或继续用户活动，则返回NO，否则返回YES。如果应用程序由于远程通知而启动，则会忽略返回值。
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"willFinishLaunchingWithOptions %@",launchOptions);
    [self setUpWindow];
    [self setUpLocalNotification:application];
    [self setUpAudioPlayBack];
    [self setUpJSPatch];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions %@",launchOptions);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    // Games should use this method to pause the game. (这个单独摘出来)
//    Xcode8开始，不需要写代码控制了，在TARGETS -> AppName -> Capabilities中可视化配置
    NSLog(@"applicationWillResignActive");
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
    // 去除应用边角数字
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // appropriate  [əˈpropriɪt] 适当的；恰当的；合适的
    NSLog(@"applicationWillTerminate");
}

// 应用还在运行，无论前台还是后台，都会调用该方法处理通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification {
    NSDictionary * dic = notification.userInfo;
    NSLog(@"%@",dic);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"eat!" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
}

// 监听远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

// 引导用户开启push
// [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
// UIApplicationLaunchOptionsKey 

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]") __TVOS_PROHIBITED {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 将deviceToken交给某方保存，如：JSPatch
    NSString* tokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    // 把deviceToken设备令牌发送给服务器，时刻保持deviceToken是最新的
} 

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0) {
    
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

//
//  AppDelegate+Extend.m
//  dolin_demo
//
//  Created by dolin999 on 2020/3/30.
//  Copyright © 2020 shaolin. All rights reserved.
//

#import "AppDelegate+Extend.h"

#import "DolinTabBarController.h"
#import "UIWindow+Expand.h"
#import <AVFoundation/AVFoundation.h>
#import <JSPatchPlatform/JSPatch.h>
#import <DoraemonKit/DoraemonManager.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Used to connect plugins.

@implementation AppDelegate (Extend)

#pragma mark -  method
- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.window.backgroundColor = [UIColor whiteColor];
    DolinTabBarController* dolinTabBarController = [[DolinTabBarController alloc]init];
    self.window.rootViewController = dolinTabBarController;
    [self.window makeKeyAndVisible];
    // 这行代码需放到 makeKeyAndVisible 之后且 window 需要自行初始化
    [self.window showLanuchPageAndSetSomeOthers];
}

- (void)setupLocalNotification:(UIApplication*)application {
//    开始本地推送通知：
//    第一种方法，延时推送，根据本地通知对象的 fireDate 设置进行本地推送通知
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

- (UILocalNotification *)makeLocalNotification {
    // 重点 先取消掉上一次的全部notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 创建本地推送通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    NSDate *resDate = [formatter dateFromString:@"2017-05-16 13-30-00"];
    notification.fireDate = resDate;
    // 记得设置当前时区，没有设置的话，fireDate将不考虑时区，这样的通知会不准确
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 每隔一天触发一次
    notification.repeatInterval = NSCalendarUnitDay;
    //设置通知属性
    notification.alertBody = @"get up & work,come on dolin!😆";// 通知主体
    notification.applicationIconBadgeNumber = 1; // 应用程序图标右上角显示的消息数
    notification.alertAction = @"The title of the action button or slider.";  // 待机界面的滑动动作提示
    notification.alertLaunchImage = @"Default"; // 通过点击通知打开应用时的启动图片,这里使用程序启动图片
    notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    // 设置用户信息
    notification.userInfo = @{
                               @"user":@"dolin",
                               @"msg":@"message"
                               }; // 绑定到通知上的其他附加信息
    
    return notification;
}

- (void)setupAudioPlayBack {
    // 让音乐可以在后台播放
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
}

- (void)setupJSPatch {
    // 测试JSPatch
    [JSPatch testScriptInBundle];
}

- (void)setupDoraemonKit {
#ifdef DEBUG
    [[DoraemonManager shareInstance] install];
#endif
}

- (void)setup3DTouch {
    NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    
    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"co.erplus.search" localizedTitle:@"搜索" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [arrShortcutItem addObject:shoreItem1];
    
    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"co.erplus.newTask" localizedTitle:@"新建任务" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    [arrShortcutItem addObject:shoreItem2];
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;

}

- (void)setupFlutter {
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
    // Runs the default Dart entrypoint with a default Flutter route.
    [self.flutterEngine run];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
}
@end

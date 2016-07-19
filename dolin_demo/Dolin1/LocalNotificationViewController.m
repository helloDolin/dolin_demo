//
//  LocalNotificationViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/19.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "LocalNotificationViewController.h"

@interface LocalNotificationViewController ()

@property(nonatomic,strong)UIButton* btn;

@end

@implementation LocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RANDOM_UICOLOR;
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5]; // 触发通知的时间
    notification.alertBody = @"alertBody";
    notification.timeZone = [NSTimeZone defaultTimeZone]; // 设置时区
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.repeatInterval = kCFCalendarUnitDay;
    notification.userInfo = @{
                              @"name":@"dolin",
                              @"sex":@"man"
                              };
    
    // 发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    // 修改badge
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

- (UIButton*)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(0, 0,SCREEN_WIDTH , 50);
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn setTitle:@"test" forState:UIControlStateNormal];
        _btn.tintColor = [UIColor whiteColor];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



@end

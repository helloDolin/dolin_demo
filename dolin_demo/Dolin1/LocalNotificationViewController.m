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
        CGFloat btnWidth = 40.0;
        CGFloat btnHeight = 40.0 + 13.0;
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 0,btnWidth,btnHeight);
        _btn.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT_NOT_NAVIGATIONBAR_AND_TABBAR / 2);
        [_btn setImage:[UIImage imageNamed:@"btn_home_test"] forState:UIControlStateNormal];
        [_btn setTitle:@"test" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _btn.backgroundColor = RANDOM_UICOLOR;
        _btn.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0); // img往上偏移5
        _btn.titleEdgeInsets = UIEdgeInsetsMake(40, -40, 0, 0); // title 往下偏移40 往左偏移40
        
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



@end

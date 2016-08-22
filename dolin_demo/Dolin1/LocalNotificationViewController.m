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
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 0,300,300);
        _btn.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT_NOT_NAVIGATIONBAR_AND_TABBAR / 2);
        [_btn setImage:[UIImage imageNamed:@"btn_like"] forState:UIControlStateNormal];
        [_btn setTitle:@"test" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        _btn.backgroundColor = [UIColor cyanColor];
        
        // 图片在左边，全部居中
        CGFloat spacing = 20;
        CGSize imageSize;
        CGSize titleSize;
        
        
//        imageSize = _btn.imageView.frame.size;
//        _btn.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - spacing/2);
//        // 对titleEdgeInsets的属性赋值之后，title的宽度可能会变化，所以我们需要在titleEdgeInsets赋值之后去获取titleSize
//        titleSize = _btn.titleLabel.frame.size;
//        _btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing/2, 0.0, 0.0);
        
//         图片在上边，全部居中
        imageSize = _btn.imageView.frame.size;
        titleSize = _btn.titleLabel.frame.size;
        spacing = 2;
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);
        titleSize = _btn.titleLabel.frame.size;
        _btn.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), 0.0, 0.0, - titleSize.width);
        
        // 图片在右边，全部居中
//        spacing = 20;
//        imageSize = _btn.imageView.frame.size;
//        _btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing/2);
//        titleSize = _btn.titleLabel.frame.size;
//        _btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing/2, 0.0, - titleSize.width);
//
        // 图片在右边，文字居中
//        imageSize = _btn.imageView.frame.size;
//        _btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, 0.0);
//        titleSize = _btn.titleLabel.frame.size;
//        _btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + imageSize.width + spacing, 0.0, - titleSize.width);
        
        
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



@end

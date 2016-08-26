//
//  ChangeDeviceOrientVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/25.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "ChangeDeviceOrientVC.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface ChangeDeviceOrientVC ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ChangeDeviceOrientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RANDOM_UICOLOR;
    [self.view addSubview:self.imgView];
    
    // 监听设备自动旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

// 通知设备旋转了
- (void)orientChange:(NSNotification *)noti {
    [self orientChangeWithSuperView:self.view showView:self.imgView showViewRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideStatusBarAndNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showStatusBarAndNavigationBar];
}

- (void)hideStatusBarAndNavigationBar {
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)showStatusBarAndNavigationBar {
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

// 原理：给要横屏的视图添加父视图，旋转这个父视图
- (void)orientChangeWithSuperView:(UIView*)superView
                         showView:(UIView*)showView
                     showViewRect:(CGRect)showViewRect {
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    superView.layer.transform = CATransform3DIdentity;
    switch (orient) {
        case UIDeviceOrientationPortrait:
            superView.frame = [UIScreen mainScreen].bounds;
            showView.frame = showViewRect;
            break;
        case UIDeviceOrientationLandscapeLeft:
            // 父视图的frame改为 一个大正方形
            superView.frame = CGRectMake(-CGRectGetHeight([UIScreen mainScreen].bounds)+CGRectGetWidth([UIScreen mainScreen].bounds), 0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
            
            showView.frame = CGRectMake(0, 0,CGRectGetHeight([UIScreen mainScreen].bounds),CGRectGetWidth([UIScreen mainScreen].bounds));
            
            superView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case UIDeviceOrientationLandscapeRight:

            superView.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
            
            showView.frame = CGRectMake(0, 0,CGRectGetHeight([UIScreen mainScreen].bounds),CGRectGetWidth([UIScreen mainScreen].bounds));
            
            superView.transform = CGAffineTransformMakeRotation(-M_PI_2);
            break;
        default:
            superView.frame = [UIScreen mainScreen].bounds;
            showView.frame = showViewRect;
            break;
    }
}

#pragma mark - getter
- (UIImageView*)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:@"MT"];
    }
    return _imgView;
}
@end

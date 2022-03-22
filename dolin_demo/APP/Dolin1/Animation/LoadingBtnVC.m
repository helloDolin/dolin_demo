//
//  LoadingBtnVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/12.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LoadingBtnVC.h"
#import "LoadingBtn.h"
#import "DLAnimateTransition.h"

@interface LoadingBtnVC ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)LoadingBtn* loadingBtn;

@end

@implementation LoadingBtnVC

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.transitioningDelegate = self;

    WS(weakSelf);
    self.loadingBtn = [LoadingBtn LoadingBtnInitWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 30, SCREEN_WIDTH, 100) andBackgroundColor:RANDOM_UICOLOR andTitle:@"LOGIN" andTitleColor:RANDOM_UICOLOR andTitleFont:[UIFont systemFontOfSize:15] andCornerRadius:10 andClickBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.loadingBtn stopAnimateAndCallBack:^{
                LoadingBtnVC *vc = [LoadingBtnVC new];
                [weakSelf presentViewController:vc animated:YES completion:nil];
            }];
        });
    }];
    [self.view addSubview:self.loadingBtn];
    
    // dismissBtn
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - event
- (void)btnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [DLAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [DLAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypeDismiss];
}

@end

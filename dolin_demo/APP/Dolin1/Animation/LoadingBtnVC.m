//
//  LoadingBtnVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/12.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LoadingBtnVC.h"
#import "LoadingBtn.h"
#import "LinAnimateTransition.h"

@interface LoadingBtnVC ()
{
    LoadingBtn* _btn1;
}
@end

@implementation LoadingBtnVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%p",self);

    WS(weakSelf);
    _btn1 = [LoadingBtn LoadingBtnInitWithFrame:CGRectMake(0, 64, 300, 100) andBackgroundColor:RANDOM_UICOLOR andTitle:@"hello" andTitleColor:RANDOM_UICOLOR andTitleFont:[UIFont systemFontOfSize:15] andCornerRadius:10 andClickBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoadingBtnVC *vc = [LoadingBtnVC new];
            [weakSelf presentViewController:vc animated:YES completion:nil];
        });
    }];
    [self.view addSubview:_btn1];
    
    // testBtn
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 375, 64);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - method


#pragma mark - event
- (void)btnAction {
    [_btn1 stopAnimateAndCallBack:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [LinAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [LinAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypeDismiss];
}
#pragma mark - getter && setter

#pragma mark - API

#pragma mark - override

@end

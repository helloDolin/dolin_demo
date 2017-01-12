//
//  LoadingBtnVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/12.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LoadingBtnVC.h"
#import "LoadingBtn.h"

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
    _btn1 = [LoadingBtn LoadingBtnInitWithFrame:CGRectMake(0, 64, 300, 100) andBackgroundColor:RANDOM_UICOLOR andTitle:@"hello" andTitleColor:RANDOM_UICOLOR andTitleFont:[UIFont systemFontOfSize:15] andCornerRadius:10 andClickBlock:^{
//        NSLog(@"%p",self);
    }];
    [self.view addSubview:_btn1];
    
    // testBtn
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 64 + 200, 375, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"stop" forState:UIControlStateNormal];
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
        NSLog(@"动画结束");
    }];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource

#pragma mark - getter && setter

#pragma mark - API

#pragma mark - override

@end

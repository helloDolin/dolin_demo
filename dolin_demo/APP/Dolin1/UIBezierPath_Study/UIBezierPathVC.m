//
//  UIBezierPathVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/16.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "UIBezierPathVC.h"
#import "UIBezierPathView.h"

@interface UIBezierPathVC ()

@end

@implementation UIBezierPathVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBezierPathView* bezierPathView = [[UIBezierPathView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:bezierPathView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

#pragma mark - event

#pragma mark - UITableViewDelegate && UITableViewDataSource

#pragma mark - getter && setter

#pragma mark - API

#pragma mark - override

@end

//
//  ChainCodeVC.m
//  dolin_demo
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "ChainCodeVC.h"
#import "CalculatorMaker.h"
#import "NSObject+Calculator.h" 
#import "BlockAlertView.h"

@interface ChainCodeVC ()

@end

@implementation ChainCodeVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger result = [NSObject makeCalc:^(CalculatorMaker *make) {
        make.add(10).muilt(10).sub(10).divide(3);
    }];
    
    [BlockAlertView alertWithTitle:@"仿Masonry设计思路" message:@"仿Masonry设计思路\n调用可以看这个类里的一个例子，原理很简单\n但是设计思路很棒！" cancelBtnWithTitle:nil cancelBlock:nil confirmButtonWithTitle:@"yeah！" confirmBlock:nil];
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

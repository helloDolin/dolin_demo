//
//  RunTimeStudy_VC.m
//  dolin_demo
//
//  Created by dolin on 16/10/20.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "RunTimeStudy_VC.h"
#import "Runtime_Test.h"
@interface RunTimeStudy_VC ()

@end

@implementation RunTimeStudy_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Runtime_Test* t = [Runtime_Test new];
    [t performSelector:@selector(eat)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

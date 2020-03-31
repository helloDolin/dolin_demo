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
    self.view.backgroundColor = [UIColor whiteColor];
    Runtime_Test* t = [Runtime_Test new];
    [t performSelector:@selector(eat)];
}

@end

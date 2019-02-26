//
//  DolinBaseViewController.m
//  dolin_demo
//
//  Created by dolin on 16/9/2.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinBaseViewController.h"

@interface DolinBaseViewController ()

@end

@implementation DolinBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor convertHexToRGB:@"f0f0f0"];
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

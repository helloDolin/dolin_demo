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
    
#ifdef __IPHONE_7_0
    if ( IOS7_OR_LATER ) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        // 扩展的布局是否包含不透明bar
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

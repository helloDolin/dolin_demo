//
//  Dolin3ViewController.m
//  dolin_demo
//
//  Created by dolin on 16/8/30.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin3ViewController.h"
#import <React/RCTRootView.h>

@interface Dolin3ViewController ()

@end

@implementation Dolin3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"dolin_demo"
                                                  initialProperties:nil
                                                      launchOptions:nil];
    self.view = rootView;
}

@end

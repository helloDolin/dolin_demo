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
    // =============本地服务器
//    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
//    NSURL* jsCodeLocation = [NSURL URLWithString:strUrl];
//    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                         moduleName:@"dolin_demo"
//                                                  initialProperties:nil
//                                                      launchOptions:nil];
//
    
    // =============本地 bundle 资源
    NSURL* jsCodeLocation = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"ios.jsbundle" ofType:nil]];
    RCTRootView *rootView = [[RCTRootView alloc]initWithBundleURL:jsCodeLocation moduleName:@"dolin_demo" initialProperties:nil launchOptions:nil];
    
    
    self.view = rootView;

}

@end

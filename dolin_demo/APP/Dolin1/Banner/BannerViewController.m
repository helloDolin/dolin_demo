//
//  BannerViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "BannerViewController.h"
#import "DLBannerView.h"

@interface BannerViewController ()<DLBannerViewDelegate>

@end

@implementation BannerViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray* datas = @[
                       @{@"urlStr":@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"title":@"好音乐，车里听"},
                       @{@"urlStr":@"http://ws.xzhushou.cn/focusimg/52.jpg",@"title":@"雕刻时光"},
                       @{@"urlStr":@"http://ws.xzhushou.cn/focusimg/51.jpg",@"title":@"齐秦齐秦齐秦齐秦齐秦齐秦齐秦齐秦齐秦齐秦"},
                       @{@"urlStr":@"http://ws.xzhushou.cn/focusimg/50.jpg",@"title":@"你是心中的日月"},
                       ];
    DLBannerView *bannerView = [DLBannerView dlBannerViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 200) delegate:self autoScrollDelay:1 datas:datas];
    [self.view addSubview:bannerView];
}

#pragma mark -  DLBannerViewDelegate
- (void)didSelect:(id)data {
    NSLog(@"%@",data[@"title"]);
}

@end

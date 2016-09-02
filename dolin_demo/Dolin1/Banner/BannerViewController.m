//
//  BannerViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "BannerViewController.h"
#import "DolinBannerView.h"

@interface BannerViewController ()<DolinBannerViewDelegate>

/** 网络图片数组*/
@property(nonatomic,copy)NSArray* netImageArray;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DolinBannerView *dolinBannerView = [[DolinBannerView alloc]initWithFrame:CGRectMake(0, NavigtationBarHeight, self.view.frame.size.width, 200) WithInfoArr:self.netImageArray];
    
    /** 获取网络图片的index*/
    dolinBannerView.delegate = self;
    /** 添加到当前View上*/
    [self.view addSubview:dolinBannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  DolinBannerViewDelegate
- (void)didSelectBannerViewWithDic:(NSDictionary*)dic {
    NSLog(@"%@",dic);
}

#pragma mark -  getter
- (NSArray *)netImageArray {
    if(!_netImageArray) {
        _netImageArray = @[@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg"];
    }
    return _netImageArray;
}

@end
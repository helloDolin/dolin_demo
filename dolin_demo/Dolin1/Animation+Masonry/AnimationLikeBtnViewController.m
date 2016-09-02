//
//  AnimationLikeBtnViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/13.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationLikeBtnViewController.h"

@interface AnimationLikeBtnViewController ()

@property(nonatomic,strong)UIButton* likeBtn;

@end

@implementation AnimationLikeBtnViewController

#pragma mark -  life circle 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    [self.view addSubview:self.likeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点赞按钮事件
 */
- (void)likeBtnAction {
    
    static BOOL isClickLikeBtn = YES;
    [self.likeBtn setImage:[[UIImage imageNamed:(isClickLikeBtn ? @"btn_like":@"btn_unlike")]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    isClickLikeBtn = !isClickLikeBtn;
    
    // 动画核心代码
    CAKeyframeAnimation *cAKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    cAKeyframeAnimation.values = @[@(0.1),@(1.0),@(1.5)];
    cAKeyframeAnimation.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    cAKeyframeAnimation.calculationMode = kCAAnimationLinear;
    [self.likeBtn.layer addAnimation:cAKeyframeAnimation forKey:@"SHOW"];
}

#pragma mark -  getter
- (UIButton*)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _likeBtn.frame = CGRectMake(0,NavigtationBarHeight,50,50);
        _likeBtn.center = self.view.center;
        [_likeBtn setImage:[[UIImage imageNamed:@"btn_unlike"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}


@end

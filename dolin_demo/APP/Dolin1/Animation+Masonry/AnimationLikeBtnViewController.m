//
//  AnimationLikeBtnViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/13.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationLikeBtnViewController.h"

@interface AnimationLikeBtnViewController ()<CAAnimationDelegate>

@property(nonatomic,strong)UIButton* likeBtn;

@end

@implementation AnimationLikeBtnViewController

#pragma mark -  life circle 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.likeBtn];
}

/**
 *  点赞按钮事件
 */
- (void)likeBtnAction {
    
    static BOOL isClickLikeBtn = YES;
    [self.likeBtn setImage:[[UIImage imageNamed:(isClickLikeBtn ? @"btn_like":@"btn_unlike")]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    isClickLikeBtn = !isClickLikeBtn;
    
    
    [self shakeToShow:self.likeBtn];

}
#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

/**
 仿支付宝，点击二维码放大动画效果
 eg:bgView上放二维码：
 点击二维码，add 上来 ，且动画
 点击bgView remove掉

 @param aView <#aView description#>
 */
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
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

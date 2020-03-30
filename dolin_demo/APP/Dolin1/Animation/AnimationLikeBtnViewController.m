//
//  AnimationLikeBtnViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/13.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationLikeBtnViewController.h"

@interface AnimationLikeBtnViewController ()<CAAnimationDelegate>
{
    NSInteger _clickCount;
}

@property(nonatomic,strong)UIButton* likeBtn;

@end

@implementation AnimationLikeBtnViewController

#pragma mark -  life circle 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.likeBtn];
}

/**
 *  点赞按钮事件
 */
- (void)likeBtnAction {
    static BOOL isLike = NO;
    NSLog(@"%d",isLike);
    [self.likeBtn setImage:[[UIImage imageNamed:(isLike ? @"btn_unlike":@"btn_like")]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (!isLike) {
        [self addAnimationToView2:self.likeBtn];
    }
    isLike = !isLike;
}

// 改变position
- (void)addAnimationToView3:(UIView*)view {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 10;
    pathAnimation.repeatCount = 10;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 0, NAVIGATION_BAR_HEIGHT);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 312, 184, 312, 384);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 584, 512, 584);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 584, 712, 384);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [view.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

// 改变scale
- (void)addAnimationToView2:(UIView*)view {
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            view.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    } completion:nil];
}

// 改变scale
- (void)addAnimationToView1:(UIView*)view {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"开始动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束动画");
}


#pragma mark -  getter
- (UIButton*)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _likeBtn.frame = CGRectMake(0,NAVIGATION_BAR_HEIGHT,50,50);
        _likeBtn.center = self.view.center;
        [_likeBtn setImage:[[UIImage imageNamed:@"btn_unlike"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}


@end

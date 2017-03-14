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
    
    [self.view addSubview:self.likeBtn];

}

/**
 *  点赞按钮事件
 */
- (void)likeBtnAction {
    static BOOL isClickLikeBtn = YES;
    
    [self.likeBtn setImage:[[UIImage imageNamed:(isClickLikeBtn ? @"btn_like":@"btn_unlike")]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    isClickLikeBtn = !isClickLikeBtn;
    
    
    if (!isClickLikeBtn) {
        _clickCount++;
        if ((_clickCount&1) == 1) {
            [self addAnimationToView2:self.likeBtn];
        } else {
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_like"]];
            [self.likeBtn addSubview:imageView];
            imageView.frame = CGRectMake(0, 0, 15, 15);
            imageView.center = self.view.center;
            [UIView animateWithDuration:0.5 animations:^ {
                imageView.transform = CGAffineTransformScale(imageView.transform, 8, 8);
                imageView.alpha = 0;
            } completion:^(BOOL finished) {
                [imageView removeFromSuperview];
            }];
        }
    }
}

- (void)addAnimationToView3:(UIView*)view {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 10;
    
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = 10;
    

    // 创建一个CGMutablePathRef 的可变路径，并返回其句柄。
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    // 在路径上移动当前画笔的位置到一个点，这个点由CGPoint 类型的参数指定。
    CGPathMoveToPoint(curvedPath, NULL, 0, 64);
    // 从当前的画笔位置向指定位置（同样由CGPoint类型的值指定）绘制线段
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 10, 450, 310, 450);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 10, 10, 10);
    
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 312, 184, 312, 384);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 584, 512, 584);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 584, 712, 384);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 712, 184, 512, 184);
    
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [view.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

}

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


/**
 CAKeyframeAnimation

 @param view
 */
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
        _likeBtn.frame = CGRectMake(0,NavigtationBarHeight,50,50);
        _likeBtn.center = self.view.center;
        [_likeBtn setImage:[[UIImage imageNamed:@"btn_unlike"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}


@end

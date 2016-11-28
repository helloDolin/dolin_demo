//
//  PushTransition.m
//  dolin_demo
//
//  Created by dolin on 16/11/28.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "PushTransition.h"

@implementation PushTransition

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 5.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _contenxtDelegate = transitionContext;
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // pop或push时已经不再container里了 so 要加
    UIView* containerView = transitionContext.containerView;
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 2000.0; //设置透视，人眼看到的效果
    toVC.view.layer.transform = transform;
    
    // 锚点的位置苹果设计为比例
    // position：layer中锚点在superLayer中的位置坐标
    toVC.view.layer.position = CGPointMake(CGRectGetMaxX(toVC.view.frame), CGRectGetMidY(toVC.view.frame));
    toVC.view.layer.anchorPoint = CGPointMake(1, 0.5);
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = @(M_PI_2);
    animation.toValue = @0;
    animation.delegate = self;
    [toVC.view.layer addAnimation:animation forKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [_contenxtDelegate completeTransition:YES];
    }
}

@end

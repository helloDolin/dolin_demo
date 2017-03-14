//
//  LinAnimateTransition.m
//  dolin_demo
//
//  Created by dolin on 2017/3/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LinAnimateTransition.h"

@interface LinAnimateTransition()

@property (nonatomic, weak)id <UIViewControllerContextTransitioning> contenxtDelegate;
@property (nonatomic, assign) LinAnimateTransitionType linAnimateTransitionType;

@end

@implementation LinAnimateTransition

// dealloc
- (void)dealloc {
    NSLog(@"%p",_contenxtDelegate);
    NSLog(@"dolin dealloc======%s",__func__);
}

+ (LinAnimateTransition *)linAnimateTransitionWithType:(LinAnimateTransitionType)linAnimateTransitionType {
    LinAnimateTransition *obj = [[LinAnimateTransition alloc]init];
    obj.linAnimateTransitionType = linAnimateTransitionType;
    return obj;
}

#pragma mark - method
/**
 截图大法
 
 @param view
 @return
 */
- (UIImage *)snapImageForView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aImage;
}

/**
 为某个view设置锚点且不想移动layer
 在修改anchorPoint后再重新设置一遍frame就可以达到目的，这时position就会自动进行相应的改变。
 */
- (void)setUpAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view {
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorpoint;
    view.frame = oldFrame;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    _contenxtDelegate = transitionContext;

    
    // 获得即将消失的vc的v
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    // 获得即将出现的vc的v
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 获得容器view
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromeView];
    [containerView addSubview:toView];
    
    switch (self.linAnimateTransitionType) {
        case LinAnimateTransitionTypePush:
        {
            UIBezierPath *startBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((containerView.frame.size.width-100)/2, 100, 100, 100)];
            CGFloat radius = 1000;
            UIBezierPath *finalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150 - radius, 150 -radius, radius*2, radius*2)];
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.path = finalBP.CGPath;
            toView.layer.mask = maskLayer;
            
            //执行动画
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
            animation.fromValue = (__bridge id _Nullable)(startBP.CGPath);
            animation.toValue = (__bridge id _Nullable)(finalBP.CGPath);
            animation.duration = [self transitionDuration:transitionContext];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.delegate = self;
            [maskLayer addAnimation:animation forKey:@"path"];
        }
            break;
        case LinAnimateTransitionTypePop:
        {

        }
            
            break;
        case LinAnimateTransitionTypePresent:
        {
            fromeView.frame = containerView.frame;
            toView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                fromeView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
                toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
            
            break;
        case LinAnimateTransitionTypeDismiss:
        {
            fromeView.frame = containerView.frame;
            toView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                fromeView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
                toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];

        }
            break;
    }
//    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    // pop或push时已经不再container里了 so 要加
//    UIView* containerView = transitionContext.containerView;
//    [containerView addSubview:toVC.view];
//    
//    if ([fromVC isKindOfClass:[Dolin1ViewController class]]) {
//        
//        Dolin1ViewController* vc = (Dolin1ViewController*)fromVC;
//        
//        UITableViewCell* cell = [vc.tableView cellForRowAtIndexPath:[vc.tableView indexPathForSelectedRow]];
//        UIImage* snapImg = [self snapImageForView:cell];
//        UIImageView* snapImgView = [[UIImageView alloc]init];
//        snapImgView.image = snapImg;
//        snapImgView.frame = [cell convertRect:cell.bounds toView:nil];
//        
//        // 将截图添加到容器内
//        [containerView addSubview:snapImgView];
//        snapImgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//        // 酷炫动画在这里搞
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            snapImgView.transform = CGAffineTransformIdentity;
//            CGRect rect =  CGRectMake(0, 20, SCREEN_WIDTH, 44);
//            snapImgView.frame = rect;
//        } completion:^(BOOL b) {
//            [snapImgView removeFromSuperview];
//            [_contenxtDelegate completeTransition:YES];
//        }];
//    }
    
    //    CATransform3D transform = CATransform3DIdentity;
    //    transform.m34 = -1 / 2000.0; //设置透视，人眼看到的效果
    //    toVC.view.layer.transform = transform;
    //
    //    // 锚点的位置苹果设计为比例
    //    // position：layer中锚点在superLayer中的位置坐标
    ////    toVC.view.layer.position = CGPointMake(CGRectGetMaxX(toVC.view.frame), CGRectGetMidY(toVC.view.frame));
    ////    toVC.view.layer.anchorPoint = ;
    //
    //    [self setUpAnchorPoint:CGPointMake(1, 0.5) forView:toVC.view];
    //
    //    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //    animation.duration = [self transitionDuration:transitionContext];
    //    animation.fromValue = @(M_PI_2);
    //    animation.toValue = @0;
    //    animation.delegate = self;
    //    [toVC.view.layer addAnimation:animation forKey:@"rotateAnimation"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [_contenxtDelegate completeTransition:YES];
        // 清除相应控制器视图的mask
        [_contenxtDelegate viewForKey:UITransitionContextFromViewKey].layer.mask = nil;
        [_contenxtDelegate viewForKey:UITransitionContextToViewKey].layer.mask = nil;
    }
}


@end

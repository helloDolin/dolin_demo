//
//  PushTransition.m
//  dolin_demo
//
//  Created by dolin on 16/11/28.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "PushTransition.h"
#import "Dolin1ViewController.h"

@implementation PushTransition



- (void)dealloc {
    NSLog(@"%s",__func__);
}


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
 为某个view设置锚点
 ❤️❤️❤️修改anchorPoint而不想移动layer
 在修改anchorPoint后再重新设置一遍frame就可以达到目的，这时position就会自动进行相应的改变。
 因为修改锚点，layer层position会变
 @param anchorpoint
 @param view
 */
- (void)setUpAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view{
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
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // pop或push时已经不再container里了 so 要加
    UIView* containerView = transitionContext.containerView;
    [containerView addSubview:toVC.view];
    
    if ([fromVC isKindOfClass:[Dolin1ViewController class]]) {
        
        Dolin1ViewController* vc = (Dolin1ViewController*)fromVC;
        
        UITableViewCell* cell = [vc.tableView cellForRowAtIndexPath:[vc.tableView indexPathForSelectedRow]];
        UIImage* snapImg = [self snapImageForView:cell];
        UIImageView* snapImgView = [[UIImageView alloc]init];
        snapImgView.image = snapImg;
        snapImgView.frame = [cell convertRect:cell.bounds toView:nil];
        
        // 将截图添加到容器内
        [containerView addSubview:snapImgView];
        snapImgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        // 酷炫动画在这里搞
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapImgView.transform = CGAffineTransformIdentity;
            CGRect rect =  CGRectMake(0, 20, SCREEN_WIDTH, 44);
            snapImgView.frame = rect;
        } completion:^(BOOL b) {
            [snapImgView removeFromSuperview];
            [_contenxtDelegate completeTransition:YES];
        }];
    }
    
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
    }
}



@end

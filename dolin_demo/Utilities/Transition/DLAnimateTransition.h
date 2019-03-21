//
//  LinAnimateTransition.h
//  dolin_demo
//
//  Created by dolin on 2017/3/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LinAnimateTransitionType) {
    LinAnimateTransitionTypePush,
    LinAnimateTransitionTypePop,
    LinAnimateTransitionTypePresent,
    LinAnimateTransitionTypeDismiss,
};

/**
 转场动画
 */
@interface DLAnimateTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

+ (DLAnimateTransition *)linAnimateTransitionWithType:(LinAnimateTransitionType)linAnimateTransitionType;

@end

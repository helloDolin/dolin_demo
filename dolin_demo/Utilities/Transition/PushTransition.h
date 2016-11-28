//
//  PushTransition.h
//  dolin_demo
//
//  Created by dolin on 16/11/28.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 push 动画
 */
@interface PushTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property(nonatomic,strong)id <UIViewControllerContextTransitioning> contenxtDelegate;

@end

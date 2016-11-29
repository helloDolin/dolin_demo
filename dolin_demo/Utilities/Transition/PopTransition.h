//
//  PopTransition.h
//  dolin_demo
//
//  Created by shaolin on 2016/11/29.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PopTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property(nonatomic,strong)id <UIViewControllerContextTransitioning> contenxtDelegate;
@end

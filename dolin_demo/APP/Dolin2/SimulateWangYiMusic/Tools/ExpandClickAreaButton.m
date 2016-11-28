//
//  ExpandClickAreaButton.m
//  dolin_demo
//
//  Created by dolin on 16/8/29.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "ExpandClickAreaButton.h"

@implementation ExpandClickAreaButton

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat padding = 20; 
    CGRect rectBig = CGRectInset(self.bounds, -padding, -padding);
    if (CGRectContainsPoint(rectBig, point)) {
        return self;
    } else {
        return nil;
    }
}

@end

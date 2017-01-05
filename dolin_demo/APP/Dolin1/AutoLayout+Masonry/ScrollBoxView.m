//
//  ScrollBoxView.m
//  dolin_demo
//
//  Created by dolin on 17/1/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "ScrollBoxView.h"

@implementation ScrollBoxView


+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

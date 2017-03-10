//
//  Banner2Cell.m
//  dolin_demo
//
//  Created by dolin on 2017/3/10.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "Banner2Cell.h"

@implementation Banner2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.banner_lbl.layer.backgroundColor = RANDOM_UICOLOR.CGColor;
    self.banner_lbl.layer.cornerRadius = 3.f;
    self.banner_lbl.textColor = [UIColor whiteColor];
}

@end

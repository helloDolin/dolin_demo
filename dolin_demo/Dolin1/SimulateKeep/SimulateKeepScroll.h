//
//  SimulateKeepScroll.h
//  dolin_demo
//
//  Created by shaolin on 16/7/15.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulateKeepScroll : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    WithTexts:(NSArray*)texts
               dotColorNormal:(UIColor*)dotColorNormal
              dotColorCurrent:(UIColor*)dotColorCurrent;

@end

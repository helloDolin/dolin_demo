//
//  ScrollBoxView.h
//  dolin_demo
//
//  Created by dolin on 17/1/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollBoxView : UIView

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *btn;

+ (instancetype)viewFromXib;

@end

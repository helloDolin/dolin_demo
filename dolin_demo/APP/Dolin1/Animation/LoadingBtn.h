//
//  LoadingBtn.h
//  dolin_demo
//
//  Created by dolin on 17/1/12.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack)(void);

@interface LoadingBtn : UIButton

+ (instancetype)LoadingBtnInitWithFrame:(CGRect)frame
                     andBackgroundColor:(UIColor *)backgroundColor
                               andTitle:(NSString *)title
                          andTitleColor:(UIColor *)titleColor
                           andTitleFont:(UIFont *)titleFont
                        andCornerRadius:(CGFloat)cornerRadius
                          andClickBlock:(CallBack)clickBlock;

- (void)stopAnimateAndCallBack:(CallBack)callBack;

@end

//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//



#import <UIKit/UIKit.h>

/**
 *  快速方便设置navigation bar
 *  记得在声明周期合适的位置设置
 */
@interface UINavigationBar (Awesome)

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

@end

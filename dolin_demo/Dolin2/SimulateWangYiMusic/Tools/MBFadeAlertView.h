//
//  MBFadeAlertView.h
//  MatchNet
//
//  Created by 李翰阳 on 15/3/25.
//  Copyright (c) 2015年 JSLtd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自动消失的弹窗
 */
@interface MBFadeAlertView : UIView

/**
 *  弹窗显示的文字
 */
@property (copy) NSString *showText;

/**
 *  弹窗字体大小
 */
@property(retain) UIFont *textFont;

/**
 *  整个FadeView的宽度
 */
@property(assign) CGFloat fadeWidth;

/**
 *  整个FadeView的背景色
 */
@property(retain) UIColor *fadeBGColor;

/**
 *  提示语颜色
 */
@property(retain) UIColor *titleColor;

/**
 *  宽度边框
 */
@property(assign) CGFloat textOffWidth;

/**
 *  高度边框
 */
@property(assign) CGFloat textOffHeight;

/**
 *  距离屏幕下方高度
 */
@property(assign) CGFloat textBottomHeight;

/**
 *  自动消失时间
 */
@property (assign) CGFloat fadeTime;

/**
 *  背景的透明度
 */
@property(assign) CGFloat FadeBGAlpha;





/**
 *  显示弹窗
 *
 *  @param str 弹窗文字
 *
 *  @return 
 */
- (void)showAlertWith:(NSString *)str;



//用法
/*

 
 MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
[alert showAlertWith:@"啊啊啊啊啊啊啊啊啊啊"];
 
 
 
 */
@end

//
//  MMPlaceHolder.h
//  driving
//
//  Created by Ralph Li on 8/11/14.
//  Copyright (c) 2014 LJC. All rights reserved.
//


/**
 一行代码解决显示问题 简单易用
 搭建码农和设计之间的沟通桥梁 减少沟通成本(Talk is cheap. Show me the code.)
 显示大小自适应(最小支持30*30哦)
 */

#import <UIKit/UIKit.h>

@interface MMPlaceHolderConfig : NSObject

+ (MMPlaceHolderConfig*) defaultConfig;

@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, assign) BOOL showArrow;
@property (nonatomic, assign) BOOL showText;


@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL autoDisplay;
@property (nonatomic, assign) BOOL autoDisplaySystemView;
@property (nonatomic, strong) NSArray *visibleMemberOfClasses;
@property (nonatomic, strong) NSArray *visibleKindOfClasses;

@end

@interface MMPlaceHolder : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, assign) BOOL showArrow;
@property (nonatomic, assign) BOOL showText;

@end

@interface  UIView(MMPlaceHolder)

- (void)showPlaceHolder;
- (void)showPlaceHolderWithAllSubviews;
- (void)showPlaceHolderWithAllSubviews:(NSInteger)maxDepth;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth frameWidth:(CGFloat)frameWidth frameColor:(UIColor*)frameColor;

- (void)hidePlaceHolder;
- (void)hidePlaceHolderWithAllSubviews;
- (void)removePlaceHolder;
- (void)removePlaceHolderWithAllSubviews;
- (MMPlaceHolder *)getPlaceHolder;

@end

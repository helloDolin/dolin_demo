//
//  TitleContainerScrollView.h
//  dolin_demo
//
//  Created by dolin on 16/8/25.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 默认高度为40
#define kTitleContainerScrollViewHeight 40.0

typedef void (^ButtonClickBlock)(NSInteger currentPage);

@protocol TitleContainerScrollViewDelegate <NSObject>

//@property (nonatomic, strong) UIColor *underLineColor;
//- (void)setUpUnderLineColor:(UIColor*)underLineColor;

@end


@interface TitleContainerScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray   *titles;
@property (nonatomic, assign) NSInteger        currentPage;
@property (nonatomic, copy  ) ButtonClickBlock buttonClickBlock;
@property (nonatomic, weak) id<TitleContainerScrollViewDelegate> titleContainerScrollViewDelegate;

- (TitleContainerScrollView*)initWithFrame:(CGRect)frame
                      withTitleNormalColor:(UIColor*)titleNormalColor
                    withTitleSelectedColor:(UIColor*)titleSelectedColor
                    withUnderLineViewColor:(UIColor*)underLineViewColor;

/**
 *  利用block一次性初始化，不需要属性参与了
 *
 *  @param paramConfigBlock
 */
- (void)onceParameterConfig:(void(^)(CGFloat* fontSizeNormal,CGFloat* fontSizeSelected, CGFloat* underLineHeight, UIColor** underLineColor))paramConfigBlock;

@end

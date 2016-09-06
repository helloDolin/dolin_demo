//
//  TitleContainerScrollView.h
//  dolin_demo
//
//  Created by dolin on 16/8/25.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleContainerScrollView;
// 默认高度为40
#define kTitleContainerScrollViewHeight 40.0

typedef void (^ButtonClickBlock)(NSInteger currentPage);

@protocol TitleContainerScrollViewDelegate <NSObject>
 
- (UIColor*)colorOfUnderLineInTitleContainerScrollView:(TitleContainerScrollView*)titleContainerScrollView;

@end


@interface TitleContainerScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray   *titles;
@property (nonatomic, assign) NSInteger        currentPage;
@property (nonatomic, copy  ) ButtonClickBlock buttonClickBlock;
@property (nonatomic, weak) id<TitleContainerScrollViewDelegate> titleContainerScrollViewDelegate;

/**
 *  初始化方法
 *
 *  @param frame              <#frame description#>
 *  @param titleNormalColor   <#titleNormalColor description#>
 *  @param titleSelectedColor <#titleSelectedColor description#>
 *  @param underLineViewColor <#underLineViewColor description#>
 *
 *  @return <#return value description#>
 */
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

/**
 *  改变相邻两个btn及下划线的状态
 *
 *  @param scaleScale <#scaleScale description#>
 *  @param rightScale <#rightScale description#>
 *  @param leftIndex  <#leftIndex description#>
 *  @param rightIndex <#rightIndex description#>
 */
- (void)changeStatusByLeftScale:(CGFloat)leftScale rightScale:(CGFloat)rightScale leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

@end

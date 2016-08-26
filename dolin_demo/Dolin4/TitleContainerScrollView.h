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

@interface TitleContainerScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray   *titles;
@property (nonatomic, assign) NSInteger        currentPage;
@property (nonatomic, copy  ) ButtonClickBlock buttonClickBlock;

- (TitleContainerScrollView*)initWithFrame:(CGRect)frame
                      withTitleNormalColor:(UIColor*)titleNormalColor
                    withTitleSelectedColor:(UIColor*)titleSelectedColor
                    withUnderLineViewColor:(UIColor*)underLineViewColor;

@end

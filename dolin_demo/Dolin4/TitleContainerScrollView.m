//
//  TitleContainerScrollView.m
//  dolin_demo
//
//  Created by dolin on 16/8/25.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "TitleContainerScrollView.h"
#import  <pop/POP.h>    //Facebook 动画包

// 默认颜色
#define kTitleColor_normal   [UIColor blackColor]
#define kTitleColor_selected [UIColor whiteColor]
#define kUnderLineViewColor  [UIColor whiteColor]

static CGFloat kBtnTitleLblFontSize = 15.0;
static CGFloat kBtnTitleLblSelectedFontSize = 18.0;
static CGFloat kPadding             = 5.0;
static CGFloat kUnderLineViewHeight = 2.0;

@interface TitleContainerScrollView()

@property (nonatomic, strong) UIView         *underLineView;
@property (nonatomic, strong) NSMutableArray *buttonsArr;

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *underLineViewColor;

@end

@implementation TitleContainerScrollView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withTitleNormalColor:kTitleColor_normal withTitleSelectedColor:kTitleColor_selected withUnderLineViewColor:kUnderLineViewColor];
}

- (TitleContainerScrollView*)initWithFrame:(CGRect)frame
                      withTitleNormalColor:(UIColor*)titleNormalColor
                    withTitleSelectedColor:(UIColor*)titleSelectedColor
                    withUnderLineViewColor:(UIColor *)underLineViewColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleNormalColor   = titleNormalColor;
        self.titleSelectedColor = titleSelectedColor;
        self.underLineViewColor = underLineViewColor;
    }
    return self;
}

#pragma mark - event
- (void)buttonClick:(UIButton*)sender {
    self.currentPage = [self.buttonsArr indexOfObject:sender];
    if (_buttonClickBlock) {
        _buttonClickBlock(_currentPage);
    }
    UIButton *btn = (UIButton *)sender;
    [self setUpUnderLineViewPositionByBtn:btn withAnimation:YES];
}

#pragma mark - setter
- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.buttonsArr = [NSMutableArray array];
    
    CGFloat originX = 0;
    
    for (int i = 0; i < titles.count; i++) {
        if ([_titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:kBtnTitleLblFontSize];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
        
        // button.intrinsicContentSize.width + 20 btn原本宽度上再加20
        CGRect frame = CGRectMake(originX + kPadding, 0, button.intrinsicContentSize.width + 20, kTitleContainerScrollViewHeight);
        button.frame = frame;
        
        // 这种写法用意：最左边的padding 是 其他padding的一半
        originX = CGRectGetMaxX(frame) + kPadding;
        
        [self addSubview:button];
        [self.buttonsArr addObject:button];
    }
    
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.buttonsArr.lastObject frame]) + kPadding, self.frame.size.height);
    
    
    // 默认选中第一个按钮
    UIButton *firstButton = self.buttonsArr.firstObject;
    firstButton.titleLabel.font = [UIFont systemFontOfSize:kBtnTitleLblSelectedFontSize];
    [firstButton setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
    
    [self setUpUnderLineViewPositionByBtn:firstButton withAnimation:NO];
    
    [self addSubview:self.underLineView];

}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    
    UIButton *button = [_buttonsArr objectAtIndex:_currentPage];
    
    // 先重置颜色与大小
    for (UIButton *btn in _buttonsArr) {
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    }
    
    // 再设置当前btn
    button.titleLabel.font =  [UIFont systemFontOfSize:18];
    [button  setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
    
    // 精华
    CGFloat leftWeight = button.center.x - SCREEN_WIDTH / 2;
    CGFloat rightWeight = (self.contentSize.width - button.center.x) - SCREEN_WIDTH / 2;
    if (leftWeight > 0 && rightWeight >0) {
        CGPoint point= self.contentOffset;
        point.x = leftWeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentOffset = point;
        } completion:nil];
    }
    
    // 以rectangle滑动是为了解决最后一个btn的显示问题
    CGRect frame = button.frame;
    [self scrollRectToVisible:frame animated:YES];
    

    [self setUpUnderLineViewPositionByBtn:button withAnimation:YES];
}

#pragma mark - method
/**
 *  设置下划线的位置
 */
- (void)setUpUnderLineViewPositionByBtn:(UIButton*)btn withAnimation:(BOOL)isAnimation{
    if (isAnimation) {
        [UIView animateWithDuration:0.25f animations:^{
            [self setUpUnderLineViewPositionByBtn:btn];
        }];
    }
    else {
        [self setUpUnderLineViewPositionByBtn:btn];
    }
}

- (void)setUpUnderLineViewPositionByBtn:(UIButton*)btn {
    self.underLineView.frame = CGRectMake(0, 0, btn.frame.size.width,kUnderLineViewHeight);
    self.underLineView.center = CGPointMake(btn.center.x, kTitleContainerScrollViewHeight - kUnderLineViewHeight);
}

#pragma mark - getter
- (UIView*)underLineView {
    if (!_underLineView) {
        _underLineView = [[UIView alloc]init];
        _underLineView.backgroundColor = _underLineViewColor;
    }
    return _underLineView;
}

@end

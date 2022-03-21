//
//  AutoLayout+ScrollViewVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "AutoLayout_ScrollViewVC.h"

@interface ScrollBoxView ()

@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UILabel *rightLbl;

@end

@implementation ScrollBoxView : UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 从 xib 实例化
//+ (instancetype)viewFromXib {
//    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
//}

- (void)setupUI {
    [self addSubview:self.leftLbl];
    [self addSubview:self.rightLbl];

    [self.leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightLbl.mas_left).offset(-10);
    }];
    
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.centerY.equalTo(self);
    }];
    
    // 默认：左边完全显示，右边超长 ...
    // 优先级设置：左边... 右边完全显示
    [self.leftLbl setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
//    [self.rightLbl setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILabel *)leftLbl {
    if (!_leftLbl) {
        _leftLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftLbl.textAlignment = NSTextAlignmentLeft;
        _leftLbl.textColor = [UIColor blackColor];
        _leftLbl.font = [UIFont systemFontOfSize:18];
        _leftLbl.text = @"test";
    }
    return  _leftLbl;
}

- (UILabel *)rightLbl {
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLbl.textAlignment = NSTextAlignmentLeft;
        _rightLbl.textColor = [UIColor blackColor];
        _rightLbl.font = [UIFont systemFontOfSize:18];
        _rightLbl.text = @"test";
    }
    return  _rightLbl;
}

@end

@interface AutoLayout_ScrollViewVC ()

@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation AutoLayout_ScrollViewVC

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
//        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.center.equalTo(self.view);
        make.height.greaterThanOrEqualTo(@300);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        // 重点：宽度的约束一定要设置
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    
    // 这个是精髓，记录新创建的View
    ScrollBoxView* nextBoxView = nil;
    
    for (int i = 0; i < self.arr.count; i++) {
        ScrollBoxView* boxView = [[ScrollBoxView alloc]init];
        boxView.backgroundColor = RANDOM_UICOLOR;
        boxView.leftLbl.text = self.arr[i][@"name"];
        boxView.rightLbl.text = self.arr[i][@"detail"];
        
        [self.containerView addSubview:boxView];
        
        [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.height.equalTo(@ (30 + 30 * i));
            if (nextBoxView) {
                make.top.mas_equalTo(nextBoxView.mas_bottom).offset(10);
            } else {
                make.top.mas_equalTo(self.containerView.mas_top).offset(10);
            }
        }];
        
        nextBoxView = boxView;
    }
    // 这样设置约束，系统才能计算出 contentSize
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nextBoxView.mas_bottom);
    }];
}

#pragma mark - getter && setter
- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (UIView*)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
    }
    return _containerView;
}

- (NSArray *)arr {
    if (!_arr) {
        _arr = @[
            @{@"name":@"照片照片照片照片照片照片照片照片照片照片照片照片照片照片",@"detail":@"照片aaa"},
            @{@"name":@"卡片",@"detail":@"卡片aaa"},
            @{@"name":@"钱包",@"detail":@"钱包aaa"},
            @{@"name":@"A",@"detail":@""},
            @{@"name":@"B",@"detail":@""},
            @{@"name":@"C",@"detail":@""},
            @{@"name":@"D",@"detail":@""},
            @{@"name":@"E",@"detail":@""},
            @{@"name":@"F",@"detail":@""},
        ];
    }
    return _arr;
}

@end




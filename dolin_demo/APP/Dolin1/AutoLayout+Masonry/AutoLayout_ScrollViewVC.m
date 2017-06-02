//
//  AutoLayout+ScrollViewVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "AutoLayout_ScrollViewVC.h"
#import "ScrollBoxView.h"

@interface AutoLayout_ScrollViewVC ()
{
    NSArray* _arr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ScrollBoxView *scrollBoxView_photo;
@property (nonatomic, strong) ScrollBoxView *scrollBoxView_card;
@property (nonatomic, strong) ScrollBoxView *scrollBoxView_save;

@end

@implementation AutoLayout_ScrollViewVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[
                @{@"name":@"照片",@"detail":@"照片aaa"},
                @{@"name":@"卡片",@"detail":@"卡片aaa"},
                @{@"name":@"钱包",@"detail":@"钱包aaa"},
                @{@"name":@"A",@"detail":@""},
                @{@"name":@"B",@"detail":@""},
                @{@"name":@"C",@"detail":@""},
                @{@"name":@"D",@"detail":@""},
                @{@"name":@"E",@"detail":@""},
                @{@"name":@"F",@"detail":@""},
             ];
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method
- (void)layoutUI {
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.containerView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView.mas_width);
    }];
    
    
    // 这个是精髓，记录新创建的View
    ScrollBoxView* nextBoxView = nil;
    
    for (int i = 0; i < _arr.count; i++) {
        ScrollBoxView* boxView = [ScrollBoxView viewFromXib];
        boxView.name.text = _arr[i][@"name"];
        boxView.detail.text = _arr[i][@"detail"];
        [self.containerView addSubview:boxView];
        [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_containerView);
            make.height.equalTo(@ (30 + 30 * i));
            
            if ( nextBoxView )
            {
                make.top.mas_equalTo(nextBoxView.mas_bottom).offset(10);
            }
            else
            {
                make.top.mas_equalTo(_containerView.mas_top).offset(10);
            }
        }];
        
        nextBoxView = boxView;
    }
    
    // 这样设置自动约束，系统才能计算出 contentSize
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nextBoxView.mas_bottom);
    }];
}
#pragma mark - event

#pragma mark - UITableViewDelegate && UITableViewDataSource

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

- (ScrollBoxView*)scrollBoxView_photo {
    if (!_scrollBoxView_photo) {
        _scrollBoxView_photo = [ScrollBoxView viewFromXib];
    }
    return _scrollBoxView_photo;
}

- (ScrollBoxView*)scrollBoxView_card {
    if (!_scrollBoxView_card) {
        _scrollBoxView_card = [ScrollBoxView viewFromXib];
    }
    return _scrollBoxView_card;
}

- (ScrollBoxView*)scrollBoxView_save {
    if (!_scrollBoxView_save) {
        _scrollBoxView_save = [ScrollBoxView viewFromXib];
    }
    return _scrollBoxView_save;
}
#pragma mark - API

#pragma mark - override

@end

//
//  InterviewVC.m
//  dolin_demo
//
//  Created by dolin on 2017/4/18.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "AutoLayoutPriority.h"

@interface AutoLayoutPriority ()

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UILabel *rightLbl;

@end

@implementation AutoLayoutPriority

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.testView];
    [self.view addSubview:self.leftLbl];
    [self.view addSubview:self.rightLbl];
    
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(self->_rightLbl.mas_left).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
    }];
    
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.equalTo(self->_leftLbl.mas_top);
    }];
    
    // 设置左边label抗压缩优先级低于默认750，所以当有抗压缩情景时，右边全部显示，左边...
    [_leftLbl setContentCompressionResistancePriority:700
                                              forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILabel*)leftLbl {
    if (!_leftLbl) {
        _leftLbl = [[UILabel alloc]init];
        _leftLbl.text = @"leftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleftleft";
        _leftLbl.numberOfLines = 0;
    }
    return _leftLbl;
}

- (UILabel*)rightLbl {
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc]init];
        _rightLbl.text = @"right";
    }
    return _rightLbl;
}

@end

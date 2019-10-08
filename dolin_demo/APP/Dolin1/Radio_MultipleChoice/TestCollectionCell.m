//
//  TestCollectionCell.m
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "TestCollectionCell.h"

@interface TestCollectionCell()

@property (nonatomic, strong) UILabel *lbl;

@end

@implementation TestCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self unSelectedStyle];
    self.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6;
    self.contentView.layer.borderWidth = 1;
    [self.contentView addSubview:self.lbl];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)unSelectedStyle {
    self.contentView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.lbl.textColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blueColor];
}

- (void)selectedStyle {
    self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
    self.lbl.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor redColor];
}

- (UILabel *)lbl {
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbl.textAlignment = NSTextAlignmentCenter;
        _lbl.textColor = [UIColor blackColor];
        _lbl.font = [UIFont systemFontOfSize:18];
    }
    return  _lbl;
}

- (void)setModel:(TestModel *)model {
    _model = model;
    self.lbl.text = _model.title;
    if (_model.isSelected) {
        [self selectedStyle];
    } else {
        [self unSelectedStyle];
    }
}


@end

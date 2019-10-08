//
//  TestHeader.m
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "TestHeader.h"

@implementation TestHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headerLbl];
    [self.headerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UILabel *)headerLbl {
    if (!_headerLbl) {
        _headerLbl = [[UILabel alloc]init];
        _headerLbl.textColor = [UIColor blackColor];
        _headerLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _headerLbl;
}

@end

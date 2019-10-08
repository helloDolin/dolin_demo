//
//  TestFooter.m
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "TestFooter.h"

@interface TestFooter()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TestFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.lineView];
}

- (UIView*)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:self.bounds];
        _lineView.backgroundColor = [UIColor convertHexToRGB:@"e5e5e5"];
    }
    return _lineView;
}
@end

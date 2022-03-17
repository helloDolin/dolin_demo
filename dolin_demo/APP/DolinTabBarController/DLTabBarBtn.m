//
//  DLTabBarBtn.m
//  dolin_demo
//
//  Created by 廖少林 on 2022/3/17.
//  Copyright © 2022 shaolin. All rights reserved.
//

#import "DLTabBarBtn.h"

@interface DLTabBarBtn()

@property (nonatomic, strong) UIView *badgeBgView;
@property (nonatomic, strong) UILabel *badgeLbl;

@end

@implementation DLTabBarBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.badgeBgView];
    [self addSubview:self.badgeLbl];
    
    [self.badgeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.badgeLbl);
        make.width.and.height.equalTo(self.badgeLbl).offset(2);
    }];
    
    [self.badgeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(4);
        make.left.equalTo(self.mas_centerX).offset(2);
        make.height.mas_equalTo(13);
    }];
}

- (void)layoutBadgeVlaue {
    CGSize size = [self.badgeLbl sizeThatFits:CGSizeMake(30, 13)];
    CGFloat width = size.width + 6;
    if (width < 13) {
        width = 13;
    }

    [self.badgeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
}

#pragma mark - getter
- (UIView *)badgeBgView {
    if (!_badgeBgView) {
        _badgeBgView = [[UIView alloc] init];
        _badgeBgView.backgroundColor = [UIColor whiteColor];
        _badgeBgView.hidden = YES;
    }
    return _badgeBgView;
}

- (UILabel *)badgeLbl {
    if (!_badgeLbl) {
        _badgeLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _badgeLbl.backgroundColor = [UIColor redColor];
        _badgeLbl.textColor = [UIColor whiteColor];
        _badgeLbl.textAlignment = NSTextAlignmentCenter;
        _badgeLbl.layer.cornerRadius = 6.f;
        _badgeLbl.layer.masksToBounds = YES;
        if (@available(iOS 8.2, *)) {
            _badgeLbl.font = [UIFont systemFontOfSize:9.f weight:UIFontWeightMedium];
        } else {
            _badgeLbl.font = [UIFont boldSystemFontOfSize:9.f];
        }
    }
    return  _badgeLbl;
}

#pragma mark - setter
- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue.length > 0) {
        self.badgeBgView.hidden = NO;
        self.badgeLbl.hidden = NO;
        self.badgeLbl.text = badgeValue;
        [self layoutBadgeVlaue];
    } else {
        self.badgeBgView.hidden = YES;
        self.badgeLbl.hidden = YES;
    }
}

@end

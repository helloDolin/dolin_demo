//
//  RecommendCellTitleView.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "RecommendCellTitleView.h"
#import "RecommendModel.h"

@interface RecommendCellTitleView()
{
    UIImageView *_avatarImageView;
    UILabel *_userNameLabel;
}

@end

@implementation RecommendCellTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    _avatarImageView = [UIImageView new];
    _avatarImageView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    
    [self addSubview:_avatarImageView];
    [self addSubview:_userNameLabel];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_avatarImageView.mas_right).offset(6);
        make.centerY.equalTo(self);
        make.height.equalTo(@(14));
    }];
}

- (void)setTitleModel:(RecommendModel *)titleModel {
    _titleModel = titleModel;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:titleModel.user.avatar_url]];
    if (titleModel.user.is_anonymous) {
        _userNameLabel.text = @"匿名";
    }else{
        _userNameLabel.text = titleModel.user.name;
    }
}

@end

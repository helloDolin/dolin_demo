//
//  RecommendCellTitleView.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "RecommendCellTitleView.h"
#import "RecommendModel.h"
#import "UIImage+DLRoundImg.h"
#import <YYText/YYText.h>

@interface RecommendCellTitleView()
{
    UIImageView *_avatarImageView;
    YYLabel *_userNameLabel;
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
    
    _userNameLabel = [YYLabel new];
    _userNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    _userNameLabel.numberOfLines = 0; // 多行显示
    _userNameLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 24; // 设置最大宽度
    
    [self addSubview:_avatarImageView];
    [self addSubview:_userNameLabel];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_avatarImageView.mas_right).offset(6);
        make.right.equalTo(self.mas_right).offset(-12);
        make.centerY.equalTo(self);
    }];
}

// 猫弄的model，暂时不用
- (void)setTitleModel:(RecommendModel *)titleModel {
    _titleModel = titleModel;
    
    // 手动剪辑圆角图片
//    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:titleModel.user.avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        UIImage* newImg = [image dl_roundImgBySize:CGSizeMake(32, 32) bgColor:[UIColor whiteColor] borderColor:RANDOM_UICOLOR borderWidth:2];
//        self->_avatarImageView.image = newImg;
//    }];
    
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:titleModel.user.avatar_url]];
    if (titleModel.user.is_anonymous) {
        _userNameLabel.text = @"匿名";
    }else{
        _userNameLabel.text = titleModel.user.name;
    }
}

- (void)setDLResultTracksModel:(DLResultTracksModel *)dLResultTracksModel {
    _dLResultTracksModel = dLResultTracksModel;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_dLResultTracksModel.album.blurPicUrl]];
    
    // 在文本末尾添加标签
    NSString *spaceName = [NSString stringWithFormat:@"%@   ",_dLResultTracksModel.name];
    
    UILabel *tagLbl = [[UILabel alloc]init];
    UIFont *font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    tagLbl.font = font;
    tagLbl.text = _dLResultTracksModel.name;
    [tagLbl sizeToFit];
    ViewBorderRadius(tagLbl, 5, 1,RANDOM_UICOLOR);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:spaceName];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:tagLbl contentMode:UIViewContentModeBottom attachmentSize:tagLbl.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
    _userNameLabel.attributedText = text;
}

@end

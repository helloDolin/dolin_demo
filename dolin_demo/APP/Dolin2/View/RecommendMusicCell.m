//
//  RecommendMusicCell.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "RecommendMusicCell.h"
#import "RecommendCellTitleView.h"
#import "RecommendModel.h"
#import "MusicCDView.h"
#import "MusicProgressView.h"
#import "MNMusicPlayer.h"

@interface RecommendMusicCell()
{
    RecommendCellTitleView *_titleView;
    MusicCDView *_musicCDView;
    MusicProgressView *_progressView;
    UIImageView *_picImageView; //_musicCDView _progressView 的容器
    UILabel *_titleLabel;
    UILabel *_descripLabel;
    UIView *_contentView; // tableView的contentView
}
@end

@implementation RecommendMusicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    _contentView = self.contentView;
    
    _titleView = [[RecommendCellTitleView alloc]init];
    
    _picImageView = [UIImageView new];
    _picImageView.backgroundColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1];
    _picImageView.contentMode = UIViewContentModeScaleAspectFill;
    _picImageView.layer.masksToBounds = YES;
    _picImageView.userInteractionEnabled = YES;
    
    _musicCDView = [MusicCDView new];
    _progressView = [MusicProgressView new];
    
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = [UIFont systemFontOfSize:19];
    _titleLabel.layer.masksToBounds = YES;
     _titleLabel.backgroundColor = [UIColor whiteColor];
    
    _descripLabel = [UILabel new];
    _descripLabel.font = [UIFont systemFontOfSize:13];
    _descripLabel.textColor = [UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:1];
    _descripLabel.numberOfLines = 0;
    _descripLabel.layer.masksToBounds = YES;
    _descripLabel.backgroundColor = [UIColor whiteColor];
    
    UIView* separateView = [[UIView alloc]init];
    separateView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    // content 添加
    [_contentView addSubview:_titleView];
    [_contentView addSubview:_picImageView];
    [_contentView addSubview:_titleLabel];
    [_contentView addSubview:_descripLabel];
    [_contentView addSubview:separateView];
    [_picImageView addSubview:_musicCDView];
    [_picImageView addSubview:_progressView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(tapAction)];
    [_picImageView addGestureRecognizer:tap];
    
    // 添加约束 (约束的bottom一定要设置，即使已经设置了高度，否则自动计算高度不行)
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self->_contentView);
        make.height.equalTo(@(60));
        make.bottom.equalTo(self->_picImageView.mas_top);
    }];
    
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_contentView.mas_left).offset(12);
        make.right.equalTo(self->_contentView.mas_right).offset(-12);
        make.height.equalTo(@(200));
        make.top.equalTo(self->_titleView.mas_bottom);
        make.bottom.equalTo(self->_titleLabel.mas_top).offset(-15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_picImageView.mas_bottom).offset(15);
        make.left.right.equalTo(self->_picImageView);
        make.height.lessThanOrEqualTo(@(40));
    }];
    
    [_descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self->_picImageView);
        make.bottom.equalTo(separateView.mas_top).offset(-10);
    }];
    
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_descripLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self->_contentView);
        make.height.equalTo(@(10));
        make.bottom.equalTo(self->_contentView.mas_bottom);
    }];
    
    [_musicCDView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_picImageView).offset(45);
        make.left.equalTo(self->_picImageView).offset(30);
        make.right.equalTo(self->_picImageView).offset(-30);
        make.height.equalTo([NSNumber numberWithFloat:SCREEN_WIDTH - 84]);
    }];

    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self->_picImageView);
        make.height.equalTo(@(40));
    }];

}

- (void)setRecommendModel:(RecommendModel *)recommendModel {
    _recommendModel = recommendModel;
    
    _titleView.titleModel = recommendModel;
    _musicCDView.model = recommendModel;
    _progressView.model = recommendModel;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:recommendModel.thumb.raw]];
    _titleLabel.text = recommendModel.title;
    _descripLabel.text = recommendModel.descrip ? :@"";
    
    if ([[MNMusicPlayer defaultPlayer].url.absoluteString isEqualToString:recommendModel.music_url] && [MNMusicPlayer defaultPlayer].isPlaying) {
        [_musicCDView playMusic];
    }else{
        [_musicCDView stopMusic];
    }
}

- (void)tapAction {
    [[MNMusicPlayer defaultPlayer] playFromURL:[NSURL URLWithString:self.recommendModel.music_url]];
}

@end

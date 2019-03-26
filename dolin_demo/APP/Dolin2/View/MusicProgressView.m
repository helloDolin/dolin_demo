//
//  MusicProgressView.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "MusicProgressView.h"
#import "RecommendModel.h"
#import "XDProgressView.h"
#import "MNMusicPlayer.h"

@interface MusicProgressView()
{
    XDProgressView *_pView;
    UIButton *_playBtn;
    UILabel *_musicTitleLabel;
    UILabel *_timeLabel;
    UIImageView *_musicImageView;
}
@end

@implementation MusicProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _pView = [XDProgressView new];
    _pView.progressTintColor = [UIColor colorWithRed:0.1 green:0.67 blue:0.96 alpha:0.5];
    _pView.trackTintColor = [UIColor clearColor];
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn setImage:[UIImage imageNamed:@"icon-player-play-white"] forState:UIControlStateNormal];
    // icon-player-play-white
    
    
    _musicTitleLabel = [UILabel new];
    _musicTitleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    _musicTitleLabel.textColor = [UIColor whiteColor];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    _timeLabel.textColor = [UIColor whiteColor];
    
    _musicImageView = [UIImageView new];
    [_musicImageView setImage:[UIImage imageNamed:@"icon-player-logo-blue"]];
    
    [self addSubview:_pView];
    [self addSubview:_playBtn];
    [self addSubview:_musicTitleLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_musicImageView];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(14, 16));
    }];
    
    [_musicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_musicImageView.mas_right).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    
    [_musicTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_playBtn.mas_left).offset(20);
        make.right.equalTo(self->_timeLabel.mas_right).offset(-15);
        make.centerY.equalTo(self);
    }];
    
    [_pView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_playBtn.mas_left).offset(15);
        make.right.equalTo(self->_timeLabel.mas_left);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingNoti:) name:MNPlayingMusicNotification object:nil];
    
}

- (void)playingNoti:(NSNotification*)noti {
    if ([[MNMusicPlayer defaultPlayer].url.absoluteString isEqualToString:self.model.music_url] && [MNMusicPlayer defaultPlayer].isPlaying) {
        _timeLabel.text = noti.object[@"currentTime"];
        _pView.progress = [noti.object[@"progress"]floatValue];
        [_playBtn setImage:[UIImage imageNamed:@"icon-player-pause-white"] forState:UIControlStateNormal];
    }
    else {
        _timeLabel.text = [self getMMSSFromSS:self.model.music_duration];
        _pView.progress = 0.0;
        [_playBtn setImage:[UIImage imageNamed:@"icon-player-play-white"] forState:UIControlStateNormal];
    }
    
}

-(void)setModel:(RecommendModel *)model {
    _model = model;
    _pView.progress = 0.0;
    _musicTitleLabel.text = [NSString stringWithFormat:@"%@ - %@",model.song_name,model.artist];
    _timeLabel.text = [self getMMSSFromSS:model.music_duration];
}

- (NSString *)getMMSSFromSS:(unsigned int)totalTime
{
    NSString *str_minute = [NSString stringWithFormat:@"%02u",(totalTime%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02u",totalTime%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}
@end

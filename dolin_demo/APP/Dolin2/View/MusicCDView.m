//
//  MusicCDView.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "MusicCDView.h"
#import "RecommendModel.h"

@interface MusicCDView()
{
    UIImageView *_cdImageView;
    UIImageView *_coverImageView;
    CABasicAnimation *_anim;
}
@end

@implementation MusicCDView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    
    _cdImageView = [UIImageView new];
    _cdImageView.image = [UIImage imageNamed:@"icon-disc"];
    
    _coverImageView = [UIImageView new];
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.layer.cornerRadius = (SCREEN_WIDTH - 84) / 6;
    
    [self addSubview:_cdImageView];
    [self addSubview:_coverImageView];
    
    [_cdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo((SCREEN_WIDTH - 84) / 3);
        make.height.mas_equalTo((SCREEN_WIDTH - 84) / 3);
    }];
    
    // 创建一个全局的动画
    _anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _anim.fromValue = @(0.0);
    _anim.toValue = @(2 * M_PI);
    _anim.duration = 10;
    _anim.autoreverses = NO;
    _anim.beginTime = 0; // 延迟0秒后执行动画
    _anim.fillMode = kCAFillModeForwards; // 动画结束之后保持在动画的最后一帧
    _anim.repeatCount = HUGE_VAL;
    
    self.alpha = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMusic:) name:MNPlayMusicNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopMusic) name:MNStopMusicNotification object:nil];
}

- (void)setModel:(RecommendModel *)model {
    _model = model;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.album_cover.raw]];
}

- (void)setDLResultTracksModel:(DLResultTracksModel *)dLResultTracksModel {
    _dLResultTracksModel = dLResultTracksModel;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_dLResultTracksModel.album.blurPicUrl]];
}


- (void)playMusic:(NSNotification*)noti {
    // 当通知过来的url与当前model相同时，才进行play
    NSString* musicUrl = noti.object;
    NSString* mp3Id = self.dLResultTracksModel.tracksModelId;
    NSString* mp3Url = [NSString stringWithFormat:@"http://music.163.com/song/media/outer/url?id=%@.mp3",mp3Id];
    if ([musicUrl isEqualToString:mp3Url]) {
        [self playMusic];
    }
    
//    // 仿猫弄
//    if ([musicUrl isEqualToString:self.model.music_url]) {
//        [self playMusic];
//    }
}

// 播放音乐
- (void)playMusic {
    if (self.alpha != 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
    }
    [self.layer addAnimation:_anim forKey:@"rotaion"];
}

// 暂停音乐
- (void)stopMusic {
    if (self.alpha != 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        }];
    }
    [self.layer removeAnimationForKey:@"rotaion"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

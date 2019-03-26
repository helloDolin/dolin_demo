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
    UIView *_blackHoleView;
    UIImageView *_cdImageView;
    UIImageView *_coverImageView;
    CABasicAnimation *_anim;
}
@end

@implementation MusicCDView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    _blackHoleView = [UIView new];
    _blackHoleView.backgroundColor = [UIColor blackColor];
    _blackHoleView.layer.cornerRadius = 5;
    
    _cdImageView = [UIImageView new];
    _cdImageView.image = [UIImage imageNamed:@"icon-disc"];
    
    _coverImageView = [UIImageView new];
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.layer.cornerRadius = (SCREEN_WIDTH - 84) / 6;
    
    [self addSubview:_cdImageView];
    [self addSubview:_coverImageView];
    [self addSubview:_blackHoleView];
    
    [_cdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo((SCREEN_WIDTH) - 84 / 3);
        make.height.mas_equalTo((SCREEN_WIDTH) - 84 / 3);
    }];
    
    // 创建一个全局的动画
    _anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _anim.fromValue = [NSNumber numberWithFloat:0.f];
    _anim.toValue = [NSNumber numberWithFloat: M_PI * 2];
    _anim.duration = 10;
    _anim.autoreverses = NO;
    _anim.fillMode = kCAFillModeForwards;
    _anim.repeatCount = MAXFLOAT;
    
    self.alpha = 0;
}

- (void)setModel:(RecommendModel *)model {
    _model = model;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.album_cover.raw]];
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

@end

//
//  DLVideoPlayView.m
//  dolin_demo
//
//  Created by dolin on 2017/5/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLVideoPlayView.h"

@interface DLVideoPlayView()

@property (weak, nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation DLVideoPlayView

+ (instancetype)videoPlayView {
    return [[[NSBundle mainBundle] loadNibNamed:@"DLVideoPlayView" owner:nil options:nil] firstObject];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgView.backgroundColor = [UIColor clearColor];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imgView.layer addSublayer:self.playerLayer];
}

#pragma mark - override
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}

#pragma mark - getter
- (AVPlayer *)player
{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}


#pragma mark - setter
- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.currentItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
}



@end

//
//  MNMusicPlayer.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "MNMusicPlayer.h"

@interface MNMusicPlayer()

@property (nonatomic,strong) CADisplayLink *progressTimer;

@end

@implementation MNMusicPlayer
/**
 单例播放器
 **/
+ (instancetype)defaultPlayer {
    static MNMusicPlayer* player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FSStreamConfiguration* config = [[FSStreamConfiguration alloc]init];
        config.httpConnectionBufferSize *= 2;
        config.enableTimeAndPitchConversion = YES;
        
        player = [[super alloc]initWithConfiguration:config];
        player.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
            //播放错误
        };
        player.onCompletion = ^{
            //播放完成
        };
        player.onStateChange = ^(FSAudioStreamState state) {
            switch (state) {
                case kFsAudioStreamPlaying:
                {
                    NSLog(@" 打印信息  playing.....%@",player.url.absoluteString);
                    [[NSNotificationCenter defaultCenter] postNotificationName:MNPlayMusicNotification object:player.url.absoluteString];
                    player.isPause = NO;
                }
                    break;
                case kFsAudioStreamStopped:
                {
                    NSLog(@" 打印信息  stop.....%@",player.url.absoluteString);
                    [[NSNotificationCenter defaultCenter] postNotificationName:MNStopMusicNotification object:player.url.absoluteString];
                }
                    break;
                case kFsAudioStreamPaused:
                {
                    //pause
                    player.isPause = YES;
                    //                    [GLMiniMusicView shareInstance].palyButton.selected = NO;
                    NSLog(@" 打印信息: pause %@",player.url.absoluteString);
                    [[NSNotificationCenter defaultCenter] postNotificationName:MNStopMusicNotification object:player.url.absoluteString];
                }
                    break;
                case kFsAudioStreamPlaybackCompleted:
                {
                    NSLog(@" 打印信息: 播放完成 %@",player.url.absoluteString);
                    [[NSNotificationCenter defaultCenter] postNotificationName:MNStopMusicNotification object:player.url.absoluteString];
                }
                    break;
                default:
                    break;
            }
        };
        //设置音量
        [player setVolume:0.5];
        //设置播放速率
        [player setPlayRate:1];
        player.loopState = MNOnceLoop;
    });
    return player;
}

- (void)startTimer {
    if (!_progressTimer) {
        _progressTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
        [_progressTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)playFromURL:(NSURL *)url {
    [self pause];
    if (![url.absoluteString isEqualToString:self.url.absoluteString]) {
        [self stop];
        [super playFromURL:url];
    } else {
        [super  play];
    }
    [self startTimer];
}

- (void)updateProgress {
    NSString *currentTime = [NSString stringWithFormat:@"%.2u:%.2u",self.currentTimePlayed.minute,self.currentTimePlayed.second];
    CGFloat progress = self.currentTimePlayed.playbackTimeInSeconds / self.duration.playbackTimeInSeconds;
    NSDictionary *dic = @{@"currentTime":currentTime,@"progress":[NSNumber numberWithFloat:progress]};
    [[NSNotificationCenter defaultCenter] postNotificationName:MNPlayingMusicNotification object:dic];
}

@end

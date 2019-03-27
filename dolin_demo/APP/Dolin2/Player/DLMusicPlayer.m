//
//  DLMusicPlayer.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "DLMusicPlayer.h"
#import "YYWeakProxy.h"

@interface DLMusicPlayer()

@property(nonatomic,strong)AVPlayer* player;
@property (nonatomic,strong)CADisplayLink *progressTimer;

@end

@implementation DLMusicPlayer

+ (instancetype)sharedDLMusicPlayer {
    static DLMusicPlayer* obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[DLMusicPlayer alloc]init];
    });
    return obj;
}

- (void)play:(NSString*)url {
    // url为空，直接return
    if (!url) {
        return;
    }
    
    // 判断如果传进来的url一致
    if ([url isEqualToString:self.url]) {
        [self pasuseMusic];
        return;
    }
    
    self.url = url;
    
    
    // 如果当前有正在播放的item移除观察者
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem* item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 替换当前item
    [self.player replaceCurrentItemWithPlayerItem:item];
}

- (void)startTimer {
    if (!_progressTimer) {
        _progressTimer = [CADisplayLink displayLinkWithTarget:[[YYWeakProxy alloc]initWithTarget:self] selector:@selector(updateProgress)];
        [_progressTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)updateProgress {
    NSString *currentTime = [self changeSecondsTime:[self fetchCurrentTime]];
    CGFloat progress = [self fetchProgressValue];
    NSDictionary *dic = @{@"currentTime":currentTime,@"progress":[NSNumber numberWithFloat:progress]};
    [[NSNotificationCenter defaultCenter] postNotificationName:MNPlayingMusicNotification object:dic];
}

// 将秒数转化成类似00:00的时间格式
-(NSString *)changeSecondsTime:(NSInteger)time {
    NSInteger min = time / 60;
    NSInteger seconds = time % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",min,seconds];
}

// 知识补充：value和timescale都是64位或32的integer
// timescale 表示1秒的时间被分成了多少份
// 获取总时长
- (NSInteger)fetchTotalTime {
    // 获取当前播放歌曲的总时间
    CMTime time = self.player.currentItem.duration;
    if (time.timescale == 0) {
        return 0;
    }
    // 播放秒数 = time.value/time.timescale
    return time.value / time.timescale;
}

// 获取当前的播放的时间
- (NSInteger)fetchCurrentTime {
    // 获取当前播放歌曲的时间(正在)
    CMTime time = self.player.currentItem.currentTime;
    if (time.timescale == 0) {
        return 0;
    }
    return time.value / time.timescale;
}

// 获取当前播放进度
- (CGFloat)fetchProgressValue {
    return [self fetchCurrentTime]/(CGFloat)[self fetchTotalTime];
}

- (void)playMusic {
    [self.player play];
    [self startTimer];
}

- (void)pasuseMusic {
    [self.player pause];
}

#pragma mark -  KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItemStatus status = [change[@"new"]integerValue];
    switch (status) {
        case AVPlayerItemStatusUnknown:
            NSLog(@"未知错误");
            break;
        case AVPlayerItemStatusReadyToPlay:
            [self playMusic];
            break;
        case AVPlayerItemStatusFailed:
            NSLog(@"未知错误");
            break;
    }
}

#pragma mark -  getter
- (AVPlayer*)player {
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (BOOL)isPlaying {
    if (self.player.rate == 0) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)dealloc {
    [_progressTimer invalidate];
}

@end

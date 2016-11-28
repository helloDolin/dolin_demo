//
//  PlayManager.m
//  MusicDemo
//
//  Created by dear on 16/6/16.
//  Copyright © 2016年 张华. All rights reserved.
//

#import "PlayManager.h"
@interface PlayManager ()
@property(nonatomic,strong)AVPlayer *player;

//定时器
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation PlayManager
-(NSTimer *)timer {
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}
//player懒加载
-(AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

//单例
+(instancetype)sharedManager {
    static PlayManager *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[PlayManager alloc]init];
    });
    return handle;
}

//暂停
-(void)pasuseMusic {
    [self.player pause];
    [self closeTimer];
   
}
//播放
-(void)playMusic {
    [self.player play];
    [self startTimer];
}
//准备去播放
-(void)prepareToPlayMusicWithUrl:(NSString *)url{
    //如果网址为空,则不执行任何操作
    if (!url) {
        return;
    }
    //判断当前有没有正在播放的item
    if (self.player.currentItem) {
        //移除观察者
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    //创建一个item
    AVPlayerItem *item =[AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    //观察item的加载状态
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //替换当前item
    [self.player replaceCurrentItemWithPlayerItem:item];
    //播放完成后自动跳到下一首
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playMusicEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

//本地播放方法
-(void)downloadMusicPlay:(NSString *)musicFilePath{
    //判断当前有没有正在播放的item
    if (self.player.currentItem) {
        //移除观察者
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    //创建一个item
    AVPlayerItem *item =[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:musicFilePath]];
    
    
    //观察item的加载状态
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //替换当前item
    [self.player replaceCurrentItemWithPlayerItem:item];
    //播放完成后自动跳到下一首
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playMusicEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}



//自动播放下一首事件
-(void)playMusicEnd{
    if ([self.delegate respondsToSelector:@selector(playToNextMusic)]) {
        [self.delegate playToNextMusic];
        //移除观察者
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
}

//观察者事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //得到属性改变后的状态
    AVPlayerItemStatus status =[change[@"new"]integerValue];//change为string类型
    switch (status) {
        case AVPlayerItemStatusUnknown:
            NSLog(@"未知错误");
            break;
            
            case AVPlayerItemStatusReadyToPlay:
            //调用播放方法
            [self playMusic];
            NSLog(@"准备播放");
            break;
            
        case AVPlayerItemStatusFailed:{
            NSLog(@"错误");
            
            //初始化弹窗
            MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
            [message showAlertWith:@"\n  发生未知错误  \n"];
        }
            
            
            break;
        default:
            break;
    }
}
//获取总时长
- (NSInteger)fetchTotalTime {
    //获取当前播放歌曲的总时间
    CMTime time = self.player.currentItem.duration;
    
    if (time.timescale == 0) {
        return 0;
    }
    //播放秒数 = time.value/time.timescale
    return time.value/time.timescale;
}
//获取当前的播放的时间
- (NSInteger)fetchCurrentTime{
    //获取当前播放歌曲的时间(正在)
    CMTime time = self.player.currentItem.currentTime;
    
    if (time.timescale == 0) {
        return 0;
    }
    
    return time.value/time.timescale;
}
//获取当前播放进度
- (CGFloat)fetchProgressValue {
    return [self fetchCurrentTime]/(CGFloat)[self fetchTotalTime];
}
//将秒数转化成类似00:00的时间格式
-(NSString *)changeSecondsTime:(NSInteger)time {
    NSInteger min =time/60;
    NSInteger seconds =time % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",min,seconds];
}
//快进快退方法
- (void)playMusicWithSliderValue:(CGFloat)peogress{
    //滑动之前 先暂停音乐
    [self pasuseMusic];
    [self.player seekToTime:CMTimeMake([self fetchTotalTime] * peogress, 1) completionHandler:^(BOOL finished) {
        if (finished) {
            //活动结束继续播放
            [self playMusic];
        }
    }];
}
//定时器方法
- (void)timerAction {
   // NSLog(@"%ld",[self fetchCurrentTime]);
    if ([self.delegate respondsToSelector:@selector(playManagerDelegateFetchTotalTime:currentTime:progress:)]) {
        //1.总时间  2.当期时间 3.当前进度
        NSString *totalTime = [self changeSecondsTime:[self fetchTotalTime]];//总时间
        NSString *currentTime =[self changeSecondsTime:[self fetchCurrentTime]];//当前时间
        CGFloat progress = [self fetchProgressValue];
        
        [self.delegate playManagerDelegateFetchTotalTime:totalTime  currentTime:currentTime  progress:progress];
        
        
        
    }
}
//开启定时器
-(void)startTimer {
    [self.timer fire];
}
//关闭定时器
-(void)closeTimer {
    [self.timer invalidate];
    self.timer = nil;//失效置空
}
//是否正在播放
-(BOOL)isPlaying {
    if (self.player.rate == 0) {
        return NO;
    }else{
        return YES;
    }
}

@end

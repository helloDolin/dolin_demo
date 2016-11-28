//
//  PlayManager.h
//  MusicDemo
//
//  Created by dear on 16/6/16.
//  Copyright © 2016年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol playManagerDelegate <NSObject>
//把播放的时间和进度信息传递过去
-(void)playManagerDelegateFetchTotalTime:(NSString *)totalTime currentTime:(NSString *)currentTime progress:(CGFloat)progress;
//自动播放下一首的
-(void)playToNextMusic;

@end
@interface PlayManager : NSObject

@property(nonatomic,weak)id<playManagerDelegate>delegate;


//单例
+(instancetype)sharedManager;

//暂停
-(void)pasuseMusic;

//播放
-(void)playMusic;

//准备去播放
-(void)prepareToPlayMusicWithUrl:(NSString *)url;

//本地播放方法
-(void)downloadMusicPlay:(NSString *)musicFilePath;

//快进快退方法
- (void)playMusicWithSliderValue:(CGFloat)peogress;

//是否正在播放
-(BOOL)isPlaying;

@end

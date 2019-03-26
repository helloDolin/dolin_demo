//
//  MNMusicPlayer.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "FSAudioStream.h"
@class RecommendModel;

typedef NS_ENUM(NSInteger,MNLoopState){
    MNOnceLoop = 0,//列表顺序播放
    MNSingleLoop,//单曲循环
    MNRandomLoop//随机播放
};

NS_ASSUME_NONNULL_BEGIN

@interface MNMusicPlayer : FSAudioStream

/**
是否是暂停状态
*/
@property (nonatomic,assign) BOOL isPause;

// 默认 列表顺序播放 MNOnceLoop
@property (nonatomic,assign) MNLoopState loopState;

/**
 单例播放器
 **/
+ (instancetype)defaultPlayer;

/**
 更新播放进度
 */
-(void)updateProgress;

@end

NS_ASSUME_NONNULL_END

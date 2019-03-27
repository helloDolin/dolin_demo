//
//  DLMusicPlayer.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLMusicPlayer : NSObject

@property(nonatomic,copy)NSString* url;
@property(nonatomic,assign)BOOL isPlaying;

+ (instancetype)sharedDLMusicPlayer;

- (void)play:(NSString*)url;
- (void)playMusic;
- (void)pasuseMusic;
@end

NS_ASSUME_NONNULL_END

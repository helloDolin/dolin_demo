//
//  MusicCDView.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendModel;

NS_ASSUME_NONNULL_BEGIN

@interface MusicCDView : UIView

@property(nonatomic,strong) RecommendModel *model;

- (void)playMusic;
- (void)stopMusic;

@end

NS_ASSUME_NONNULL_END

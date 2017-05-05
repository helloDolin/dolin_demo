//
//  DLVideoPlayView.h
//  dolin_demo
//
//  Created by dolin on 2017/5/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLVideoPlayView : UIView

+ (instancetype)videoPlayView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, copy) NSString *urlString;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

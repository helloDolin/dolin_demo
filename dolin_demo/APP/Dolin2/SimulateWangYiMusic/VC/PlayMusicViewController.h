//
//  Dolin2ViewController.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PlayMusicViewController : UIViewController

@property (nonatomic,assign) NSInteger index;//记录点击的是第几首歌
@property (nonatomic,assign) BOOL      gesturesState;//判断tableView和scroll手势事件
@property (nonatomic,assign) BOOL      likeState;//判断喜欢状态

//控制器的单例
+ (instancetype)sharedManager;

@end

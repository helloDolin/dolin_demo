//
//  ExpandClickAreaButton.h
//  dolin_demo
//
//  Created by dolin on 16/8/29.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Music;
typedef  void(^musicBlock)();       //加载完成后刷新UI
@interface RequestManager : NSObject

@property(nonatomic,strong)NSMutableArray *musicArray;//用来存数据的

//单利
+(instancetype)sharedManager;

//通过url读取数据
-(void)fetchDataWithUrl:(NSString *)url updateUI:(musicBlock)block;

//返回数据个数
-(NSInteger)returnArrayCount;

//返回对应下表的模型
-(Music *)returnMusicAtIndex:(NSInteger)index;

//网络状态
-(NSError *)networkInformation;

//刷新歌词
-(void)requestLyric;
@end

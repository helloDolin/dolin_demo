//
//  Dowload.h
//  DowloadDemo
//
//  Created by dear on 16/6/17.
//  Copyright © 2016年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>
//正在下载
typedef void (^Downloading)(long long bytesWitten,float progress);
//下载完成
typedef void (^Complted)(NSString *filepath,NSString *url);


@interface Dowload : NSObject
//自定义init方法,在初始化的时候就去创建一个下载任务
- (instancetype)initWithUrl:(NSString *)url;

//开始下载
-(void)startDownload;

//暂停下载
-(void)stopDownload;
//下载的时候和下载完成会走其中的block
-(void)downloading:(Downloading)downloading didFinished:(Complted)complted;
@end

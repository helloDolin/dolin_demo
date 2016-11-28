//
//  Dowload.m
//  DowloadDemo
//
//  Created by dear on 16/6/17.
//  Copyright © 2016年 张华. All rights reserved.
//

#import "Dowload.h"

@interface Dowload()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSURLSessionDownloadTask *task;
//正在下载
@property(nonatomic,copy)Downloading downloading;
//下载完成
@property(nonatomic,copy)Complted complted;

@end

@implementation Dowload
-(NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return _session;
}
//自定义init方法,在初始化的时候就去创建一个下载任务
- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        //创建一个下载任务
        self.task =[self.session downloadTaskWithURL:[NSURL URLWithString:url]];
    }
    return self;
}
//开始下载
-(void)startDownload{
    [self.task resume];
}
//暂停下载
-(void)stopDownload{
    [self.task suspend];
}

//正在下载
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
//    NSLog(@"%f%%",totalBytesWritten/(float)totalBytesExpectedToWrite *100);
    if (self.downloading) {
        self.downloading(bytesWritten,totalBytesWritten/(float)totalBytesExpectedToWrite *100);
    }
    
}

//下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //NSLog(@"%@",location);
    //我们要存放下载文件的路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //拼接文件的名字,名字是从服务器上获取下来的
    NSString *fileName = downloadTask.response.suggestedFilename;
    filePath =[filePath stringByAppendingPathComponent:fileName];
    //文件管理器,把临时的文件移动到缓存文件夹下
    [[NSFileManager defaultManager]moveItemAtPath:location.path toPath:filePath error:nil];
//    NSLog(@"%@",filePath);
    if (self.complted) {
        self.complted(filePath,@"wangzhi");
    }
    
    
}
//下载的时候和下载完成会走其中的block
-(void)downloading:(Downloading)downloading didFinished:(Complted)complted{
    self.downloading = downloading;
    self.complted = complted;
}

@end

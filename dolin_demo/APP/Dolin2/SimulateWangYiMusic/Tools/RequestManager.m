//
//  ExpandClickAreaButton.h
//  dolin_demo
//
//  Created by dolin on 16/8/29.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "RequestManager.h"
#import "Music.h"
#import "MBFadeAlertView.h"

@interface RequestManager ()

@end

@implementation RequestManager

-(NSMutableArray *)musicArray{
    if (!_musicArray) {
        _musicArray = [NSMutableArray array];
    }
    return _musicArray;
}


+(instancetype)sharedManager{
    static RequestManager *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[RequestManager alloc]init];
    });
    return handle;
}

//通过url读取数据
-(void)fetchDataWithUrl:(NSString *)url updateUI:(musicBlock)block {
    
    //子线程:用来处理耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //本地存储JSON路径
        NSString *dataPathString = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"musicJSONData"];
//         NSLog(@"%@",dataPathString);
        
        //设置网络请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
        NSLog(@"%@",url);
        //连接服务器,发送请求
        NSError *error =nil;
        NSData *musicJSONData =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        
        //如果网络好执行
        if (!error) {
            
            [musicJSONData writeToFile:dataPathString atomically:YES];
            NSLog(@"网络好,我存最新的json到本地了");
            
            //解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:musicJSONData options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dict = dic[@"result"];
            NSArray *array = dict[@"tracks"];
            
            for (NSDictionary *dic in array) {
                
                
                NSArray *arr =dic[@"artists"];
                
                //封面与专辑字典
                NSDictionary *imageAddTheAlbum = dic[@"album"];
                
                Music *music =[[Music alloc]init];
                [music setValuesForKeysWithDictionary:dic];
                //歌手名
                NSDictionary *singerDic =arr[0];
                music.singer = singerDic[@"name"];
                
                //封面
                music.picUrl = imageAddTheAlbum[@"picUrl"];
                
                //专辑名
                music.theAlbumName = imageAddTheAlbum[@"name"];
                
                //歌曲简介
                NSArray *array2 = dic[@"alias"];
                if (array2.count >0) {
                    music.musicIntroduce =array2[0];
                }
                //歌曲下载ID
                NSDictionary *musicIDDic =  dic[@"bMusic"];
                music.musicDownloadID = musicIDDic[@"dfsId"];
                
                //歌单封面url
                music.listTheCoverUrl = dict[@"coverImgUrl"];
                
                //歌单名称
                music.listName = dict[@"name"];
                
                //歌单内歌曲个数
                music.musicListCount =[NSString stringWithFormat:@"%ld",array.count];
                
                [self.musicArray addObject:music];
            }
            
            //主线程主要用来刷新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
                NSLog(@"刷新ui");
            });

        }else{
          //如果网络不好执行
            NSLog(@"没有网络,将加载本地数据");
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                //初始化弹窗
                MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
                [message showAlertWith:@"无可用网络\n你可以播放已下载的音乐"];
            });
            
            //如果本地json文件存在执行解析
            if ([[NSFileManager defaultManager] fileExistsAtPath:dataPathString]) {
                //获取本地JSON数据
                NSData *data = [NSData dataWithContentsOfFile:dataPathString];
                //解析数据
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSDictionary *dict = dic[@"result"];
                NSArray *array = dict[@"tracks"];
                
                for (NSDictionary *dic in array) {
                    
                    
                    NSArray *arr =dic[@"artists"];
                    
                    //封面与专辑字典
                    NSDictionary *imageAddTheAlbum = dic[@"album"];
                    
                    Music *music =[[Music alloc]init];
                    [music setValuesForKeysWithDictionary:dic];
                    //歌手名
                    NSDictionary *dict =arr[0];
                    music.singer = dict[@"name"];
                    
                    //封面
                    music.picUrl = imageAddTheAlbum[@"picUrl"];
                    
                    //专辑名
                    music.theAlbumName = imageAddTheAlbum[@"name"];
                    
                    //歌曲简介
                    NSArray *array2 = dic[@"alias"];
                    if (array2.count >0) {
                        music.musicIntroduce =array2[0];
                    }
                    //歌曲ID
                    NSDictionary *musicIDDic =  dic[@"bMusic"];
                    music.musicDownloadID = musicIDDic[@"dfsId"];
                    
                    //歌词
                    
                    [self.musicArray addObject:music];
                }
                
                //主线程主要用来刷新ui
                dispatch_async(dispatch_get_main_queue(), ^{
                    block();
                    NSLog(@"刷新ui");
                });
            }else{
                NSLog(@"发生错误,本地json文件不存在");
            }
            
        }
        
        
    
    });
}

//刷新歌词
-(void)requestLyric{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //歌词
        for (Music *music in self.musicArray) {
            
            NSString *lyricUrlString = [NSString stringWithFormat:@"%@%@",kLyricUrl,music.musicID];
            //设置网络请求
            NSURLRequest *lyricRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:lyricUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
            //发送请求
            NSError *error =nil;
            NSData *lyricData =[NSURLConnection sendSynchronousRequest:lyricRequest returningResponse:nil error:&error];
            
            if (!error) {
                //解析数据
                NSDictionary *lyricDic = [NSJSONSerialization JSONObjectWithData:lyricData options:NSJSONReadingAllowFragments error:nil];
                NSString  * lyricString = lyricDic[@"lyric"];
                music.lyric = lyricString;
                
            }else{
                NSLog(@"请求歌词发生错误,网络有问题");
            }
            
            
        }
        
    });
    

    


}
//网络状态
-(NSError *)networkInformation{
    

    //设置网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:kUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0];
    
    //连接服务器,发送请求
    NSError *error =nil;
    NSData *musicJSONData =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    return error;
}

//返回数据个数
-(NSInteger)returnArrayCount {

    return self.musicArray.count;
}


//返回对应下表的模型
-(Music *)returnMusicAtIndex:(NSInteger)index {
    return self.musicArray[index];
}

@end

//
//  WYMusic.h
//  dolin_demo
//
//  Created by dolin on 16/9/2.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic,strong) NSString *mp3Url;  //歌曲网址
@property (nonatomic,strong) NSString *picUrl;  //图片网址
@property (nonatomic,strong) NSString *name;    //歌名
@property (nonatomic,strong) NSString *singer;  //歌手
@property (nonatomic,strong) NSString *lyric;   //歌词
@property (nonatomic,strong) NSString *theAlbumName;//专辑名
@property (nonatomic,strong) NSString *musicIntroduce;//歌曲简介
@property (nonatomic,strong) NSString *musicID;//歌曲ID
@property (nonatomic,strong) NSString *musicDownloadID;//歌曲下载ID
@property (nonatomic,strong) NSString *listTheCoverUrl;//歌单封面
@property (nonatomic,strong) NSString *listName;//歌单名称
@property (nonatomic,strong) NSString *musicListCount;//歌单歌曲个数

@end

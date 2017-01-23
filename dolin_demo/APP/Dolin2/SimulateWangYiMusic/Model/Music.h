//
//  WYMusic.h
//  dolin_demo
//
//  Created by dolin on 16/9/2.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic,copy) NSString *mp3Url;            //歌曲网址
@property (nonatomic,copy) NSString *picUrl;            //图片网址
@property (nonatomic,copy) NSString *name;              //歌名
@property (nonatomic,copy) NSString *singer;            //歌手
@property (nonatomic,copy) NSString *lyric;             //歌词
@property (nonatomic,copy) NSString *theAlbumName;      //专辑名
@property (nonatomic,copy) NSString *musicIntroduce;    //歌曲简介
@property (nonatomic,copy) NSString *musicID;           //歌曲ID
@property (nonatomic,copy) NSString *musicDownloadID;   //歌曲下载ID
@property (nonatomic,copy) NSString *listTheCoverUrl;   //歌单封面
@property (nonatomic,copy) NSString *listName;          //歌单名称
@property (nonatomic,copy) NSString *musicListCount;    //歌单歌曲个数

@end

//
//  RecommendModel.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "MNBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendModel : MNBaseModel

@property(nonatomic,strong) NSString *Id;
@property (nonatomic,assign) NSInteger bang_count; // 点赞数
@property (nonatomic,assign) NSInteger comment_count; // 评论数
@property (nonatomic,assign) BOOL is_folded;
@property (nonatomic,copy) NSString *title; // 标题
@property (nonatomic,copy) NSString *descrip; // 内容描述
@property (nonatomic,assign) NSInteger object_type;
//@property (nonatomic,assign) MeowType meow_type;
@property (nonatomic,copy) NSString *text;
@property(nonatomic,strong) User *user;
@property(nonatomic,strong) Sort *category;
@property(nonatomic,strong) Thumb *thumb;
@property(nonatomic,strong) Thumb *logo_url_thumb;
@property(nonatomic,strong) Thumb *album_cover;
@property(nonatomic,strong) Group *group;
@property (nonatomic,assign) unsigned music_duration; // 歌曲总长(秒)
@property (nonatomic,assign) unsigned video_duration;
@property (nonatomic,assign) unsigned create_time;
@property (nonatomic,assign) NSInteger member_num;


@property (nonatomic,copy) NSString *song_name;//歌曲名
@property (nonatomic,copy) NSString *artist;//歌手名
@property (nonatomic,copy) NSString *music_url;//歌曲地址
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *rec_url;//网页地址

@property(nonatomic,strong) NSArray<Thumb*> *pics;
@property(nonatomic,strong) NSArray<Thumb*> *images;
@property (assign, nonatomic, getter = isFadedOut) BOOL hasShine;
@property(nonatomic,strong) NSURL *videoUrl;

//获取cell的identifier
@property (nonatomic,copy) NSString *cellIdentifier;

@end

NS_ASSUME_NONNULL_END

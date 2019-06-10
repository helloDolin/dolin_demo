//
//  DLModel.m
//  YBModelFileDemo
//
//  Created by indulgeIn on 2019/06/10.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "DLModel.h"
#import "NSObject+YYModel.h"


@implementation DLResultCreatorModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"description1":@"description"};
}
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultCreatorModel allocWithZone:zone] init];
    one.authority = self.authority;
    one.birthday = self.birthday;
    one.province = self.province;
    one.mutual = self.mutual;
    one.nickname = self.nickname;
    one.accountStatus = self.accountStatus;
    one.followed = self.followed;
    one.avatarImgId_str = self.avatarImgId_str;
    one.backgroundUrl = self.backgroundUrl;
    one.avatarImgIdStr = self.avatarImgIdStr;
    one.avatarUrl = self.avatarUrl;
    one.defaultAvatar = self.defaultAvatar;
    one.remarkName = self.remarkName;
    one.userType = self.userType;
    one.signature = self.signature;
    one.description1 = self.description1;
    one.authStatus = self.authStatus;
    one.city = self.city;
    one.vipType = self.vipType;
    one.djStatus = self.djStatus;
    one.gender = self.gender;
    one.experts = self.experts;
    one.backgroundImgIdStr = self.backgroundImgIdStr;
    one.expertTags = self.expertTags;
    one.detailDescription = self.detailDescription;
    one.avatarImgId = self.avatarImgId;
    one.backgroundImgId = self.backgroundImgId;
    one.userId = self.userId;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksLMusicModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksLMusicModel allocWithZone:zone] init];
    one.sr = self.sr;
    one.id = self.id;
    one.dfsId = self.dfsId;
    one.dfsId_str = self.dfsId_str;
    one.size = self.size;
    one.volumeDelta = self.volumeDelta;
    one.extension = self.extension;
    one.bitrate = self.bitrate;
    one.name = self.name;
    one.playTime = self.playTime;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksBMusicModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksBMusicModel allocWithZone:zone] init];
    one.sr = self.sr;
    one.id = self.id;
    one.dfsId = self.dfsId;
    one.dfsId_str = self.dfsId_str;
    one.size = self.size;
    one.volumeDelta = self.volumeDelta;
    one.extension = self.extension;
    one.bitrate = self.bitrate;
    one.name = self.name;
    one.playTime = self.playTime;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksHMusicModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksHMusicModel allocWithZone:zone] init];
    one.sr = self.sr;
    one.id = self.id;
    one.dfsId = self.dfsId;
    one.dfsId_str = self.dfsId_str;
    one.size = self.size;
    one.volumeDelta = self.volumeDelta;
    one.extension = self.extension;
    one.bitrate = self.bitrate;
    one.name = self.name;
    one.playTime = self.playTime;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksAlbumArtistModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksAlbumArtistModel allocWithZone:zone] init];
    one.id = self.id;
    one.briefDesc = self.briefDesc;
    one.albumSize = self.albumSize;
    one.picUrl = self.picUrl;
    one.musicSize = self.musicSize;
    one.trans = self.trans;
    one.topicPerson = self.topicPerson;
    one.img1v1Id = self.img1v1Id;
    one.alias = self.alias;
    one.picId = self.picId;
    one.img1v1Url = self.img1v1Url;
    one.name = self.name;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksAlbumArtistsModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksAlbumArtistsModel allocWithZone:zone] init];
    one.id = self.id;
    one.briefDesc = self.briefDesc;
    one.albumSize = self.albumSize;
    one.picUrl = self.picUrl;
    one.musicSize = self.musicSize;
    one.trans = self.trans;
    one.topicPerson = self.topicPerson;
    one.img1v1Id = self.img1v1Id;
    one.alias = self.alias;
    one.picId = self.picId;
    one.img1v1Url = self.img1v1Url;
    one.name = self.name;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksAlbumModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"description1":@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"artists":@"DLResultTracksAlbumArtistsModel"};
}
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksAlbumModel allocWithZone:zone] init];
    one.subType = self.subType;
    one.status = self.status;
    one.company = self.company;
    one.picUrl = self.picUrl;
    one.tags = self.tags;
    one.description1 = self.description1;
    one.songs = self.songs;
    one.companyId = self.companyId;
    one.alias = self.alias;
    one.name = self.name;
    one.type = self.type;
    one.size = self.size;
    one.id = self.id;
    one.pic = self.pic;
    one.blurPicUrl = self.blurPicUrl;
    one.artist = self.artist;
    one.commentThreadId = self.commentThreadId;
    one.briefDesc = self.briefDesc;
    one.publishTime = self.publishTime;
    one.picId_str = self.picId_str;
    one.mark = self.mark;
    one.picId = self.picId;
    one.transName = self.transName;
    one.artists = self.artists;
    one.copyrightId = self.copyrightId;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksArtistsModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksArtistsModel allocWithZone:zone] init];
    one.id = self.id;
    one.briefDesc = self.briefDesc;
    one.albumSize = self.albumSize;
    one.picUrl = self.picUrl;
    one.musicSize = self.musicSize;
    one.trans = self.trans;
    one.topicPerson = self.topicPerson;
    one.img1v1Id = self.img1v1Id;
    one.alias = self.alias;
    one.picId = self.picId;
    one.img1v1Url = self.img1v1Url;
    one.name = self.name;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksMMusicModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksMMusicModel allocWithZone:zone] init];
    one.sr = self.sr;
    one.id = self.id;
    one.dfsId = self.dfsId;
    one.dfsId_str = self.dfsId_str;
    one.size = self.size;
    one.volumeDelta = self.volumeDelta;
    one.extension = self.extension;
    one.bitrate = self.bitrate;
    one.name = self.name;
    one.playTime = self.playTime;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultTracksModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"artists":@"DLResultTracksArtistsModel",
             };
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"acopyFrom":@"copyFrom",
             @"tracksModelId":@"id",
             };
}

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultTracksModel allocWithZone:zone] init];
    one.alias = self.alias;
    one.ftype = self.ftype;
    one.tracksModelId = self.tracksModelId;
    one.commentThreadId = self.commentThreadId;
    one.lMusic = self.lMusic;
    one.duration = self.duration;
    one.bMusic = self.bMusic;
    one.score = self.score;
    one.transName = self.transName;
    one.copyright = self.copyright;
    one.no = self.no;
    one.rtUrls = self.rtUrls;
    one.audition = self.audition;
    one.hMusic = self.hMusic;
    one.album = self.album;
    one.ringtone = self.ringtone;
    one.position = self.position;
    one.rtype = self.rtype;
    one.mark = self.mark;
    one.mvid = self.mvid;
    one.name = self.name;
    one.rurl = self.rurl;
    one.playedNum = self.playedNum;
    one.status = self.status;
    one.dayPlays = self.dayPlays;
    one.hearTime = self.hearTime;
    one.starred = self.starred;
    one.sign = self.sign;
    one.rtUrl = self.rtUrl;
    one.crbt = self.crbt;
    one.artists = self.artists;
    one.fee = self.fee;
    one.popularity = self.popularity;
    one.copyrightId = self.copyrightId;
    one.mp3Url = self.mp3Url;
    one.mMusic = self.mMusic;
    one.acopyFrom = self.acopyFrom;
    one.starredNum = self.starredNum;
    one.disc = self.disc;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLResultModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"NewImported":@"newImported", @"description1":@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tracks":@"DLResultTracksModel"};
}
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLResultModel allocWithZone:zone] init];
    one.subscribers = self.subscribers;
    one.creator = self.creator;
    one.specialType = self.specialType;
    one.totalDuration = self.totalDuration;
    one.id = self.id;
    one.commentThreadId = self.commentThreadId;
    one.playCount = self.playCount;
    one.backgroundCoverId = self.backgroundCoverId;
    one.coverImgUrl = self.coverImgUrl;
    one.subscribedCount = self.subscribedCount;
    one.commentCount = self.commentCount;
    one.description1 = self.description1;
    one.privacy = self.privacy;
    one.anonimous = self.anonimous;
    one.backgroundCoverUrl = self.backgroundCoverUrl;
    one.ordered = self.ordered;
    one.adType = self.adType;
    one.updateTime = self.updateTime;
    one.trackNumberUpdateTime = self.trackNumberUpdateTime;
    one.name = self.name;
    one.shareCount = self.shareCount;
    one.trackUpdateTime = self.trackUpdateTime;
    one.status = self.status;
    one.subscribed = self.subscribed;
    one.highQuality = self.highQuality;
    one.updateFrequency = self.updateFrequency;
    one.cloudTrackCount = self.cloudTrackCount;
    one.tags = self.tags;
    one.NewImported = self.NewImported;
    one.coverImgId = self.coverImgId;
    one.artists = self.artists;
    one.tracks = self.tracks;
    one.createTime = self.createTime;
    one.trackCount = self.trackCount;
    one.coverImgId_str = self.coverImgId_str;
    one.userId = self.userId;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end


@implementation DLModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[DLModel allocWithZone:zone] init];
    one.result = self.result;
    one.code = self.code;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
@end



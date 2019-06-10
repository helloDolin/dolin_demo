//
//  DLModel.h
//  YBModelFileDemo
//
//  Created by indulgeIn on 2019/06/10.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface DLResultCreatorModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger authority;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) BOOL mutual;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger accountStatus;
@property (nonatomic, assign) BOOL followed;
@property (nonatomic, copy) NSString *avatarImgId_str;
@property (nonatomic, copy) NSString *backgroundUrl;
@property (nonatomic, copy) NSString *avatarImgIdStr;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, assign) BOOL defaultAvatar;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *description1;
@property (nonatomic, assign) NSInteger authStatus;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, assign) NSInteger vipType;
@property (nonatomic, assign) NSInteger djStatus;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *experts;
@property (nonatomic, copy) NSString *backgroundImgIdStr;
@property (nonatomic, copy) NSString *expertTags;
@property (nonatomic, copy) NSString *detailDescription;
@property (nonatomic, assign) NSInteger avatarImgId;
@property (nonatomic, assign) NSInteger backgroundImgId;
@property (nonatomic, assign) NSInteger userId;
@end


@interface DLResultTracksLMusicModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, copy) NSString *dfsId_str;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) double volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;
@end


@interface DLResultTracksBMusicModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, copy) NSString *dfsId_str;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) double volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;
@end


@interface DLResultTracksHMusicModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, copy) NSString *dfsId_str;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) double volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;
@end


@interface DLResultTracksAlbumArtistModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger musicSize;
@property (nonatomic, copy) NSString *trans;
@property (nonatomic, assign) NSInteger topicPerson;
@property (nonatomic, assign) NSInteger img1v1Id;
@property (nonatomic, copy) NSArray *alias;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *img1v1Url;
@property (nonatomic, copy) NSString *name;
@end


@interface DLResultTracksAlbumArtistsModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger musicSize;
@property (nonatomic, copy) NSString *trans;
@property (nonatomic, assign) NSInteger topicPerson;
@property (nonatomic, assign) NSInteger img1v1Id;
@property (nonatomic, copy) NSArray *alias;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *img1v1Url;
@property (nonatomic, copy) NSString *name;
@end


@interface DLResultTracksAlbumModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSString *subType;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *description1;
@property (nonatomic, copy) NSArray *songs;
@property (nonatomic, assign) NSInteger companyId;
@property (nonatomic, copy) NSArray *alias;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger pic;
@property (nonatomic, copy) NSString *blurPicUrl;
@property (nonatomic, strong) DLResultTracksAlbumArtistModel *artist;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, assign) NSInteger publishTime;
@property (nonatomic, copy) NSString *picId_str;
@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *transName;
@property (nonatomic, copy) NSArray<DLResultTracksAlbumArtistsModel *> *artists;
@property (nonatomic, assign) NSInteger copyrightId;
@end


@interface DLResultTracksArtistsModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger musicSize;
@property (nonatomic, copy) NSString *trans;
@property (nonatomic, assign) NSInteger topicPerson;
@property (nonatomic, assign) NSInteger img1v1Id;
@property (nonatomic, copy) NSArray *alias;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *img1v1Url;
@property (nonatomic, copy) NSString *name;
@end


@interface DLResultTracksMMusicModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, copy) NSString *dfsId_str;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) double volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;
@end


@interface DLResultTracksModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSArray *alias;
@property (nonatomic, assign) NSInteger ftype;
@property (nonatomic, copy) NSString* tracksModelId;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, strong) DLResultTracksLMusicModel *lMusic;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) DLResultTracksBMusicModel *bMusic;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString *transName;
@property (nonatomic, assign) NSInteger copyright;
@property (nonatomic, assign) NSInteger no;
@property (nonatomic, copy) NSArray *rtUrls;
@property (nonatomic, copy) NSString *audition;
@property (nonatomic, strong) DLResultTracksHMusicModel *hMusic;
@property (nonatomic, strong) DLResultTracksAlbumModel *album;
@property (nonatomic, copy) NSString *ringtone;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign) NSInteger rtype;
@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, assign) NSInteger mvid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *rurl;
@property (nonatomic, assign) NSInteger playedNum;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger dayPlays;
@property (nonatomic, assign) NSInteger hearTime;
@property (nonatomic, assign) BOOL starred;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *rtUrl;
@property (nonatomic, copy) NSString *crbt;
@property (nonatomic, copy) NSArray<DLResultTracksArtistsModel *> *artists;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, assign) double popularity;
@property (nonatomic, assign) NSInteger copyrightId;
@property (nonatomic, copy) NSString *mp3Url;
@property (nonatomic, strong) DLResultTracksMMusicModel *mMusic;
@property (nonatomic, copy) NSString *acopyFrom;
@property (nonatomic, assign) NSInteger starredNum;
@property (nonatomic, copy) NSString *disc;
@end


@interface DLResultModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSArray *subscribers;
@property (nonatomic, strong) DLResultCreatorModel *creator;
@property (nonatomic, assign) NSInteger specialType;
@property (nonatomic, assign) NSInteger totalDuration;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger backgroundCoverId;
@property (nonatomic, copy) NSString *coverImgUrl;
@property (nonatomic, assign) NSInteger subscribedCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, copy) NSString *description1;
@property (nonatomic, assign) NSInteger privacy;
@property (nonatomic, assign) BOOL anonimous;
@property (nonatomic, copy) NSString *backgroundCoverUrl;
@property (nonatomic, assign) BOOL ordered;
@property (nonatomic, assign) NSInteger adType;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) NSInteger trackNumberUpdateTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger shareCount;
@property (nonatomic, assign) NSInteger trackUpdateTime;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL subscribed;
@property (nonatomic, assign) BOOL highQuality;
@property (nonatomic, copy) NSString *updateFrequency;
@property (nonatomic, assign) NSInteger cloudTrackCount;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, assign) BOOL NewImported;
@property (nonatomic, assign) NSInteger coverImgId;
@property (nonatomic, copy) NSString *artists;
@property (nonatomic, copy) NSArray<DLResultTracksModel *> *tracks;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, copy) NSString *coverImgId_str;
@property (nonatomic, assign) NSInteger userId;
@end


@interface DLModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, strong) DLResultModel *result;
@property (nonatomic, assign) NSInteger code;
@end


NS_ASSUME_NONNULL_END

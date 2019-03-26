//
//  MONOModel.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// recent_participant_info 之下
@interface MNBaseModel : NSObject

@property (nonatomic,assign) NSInteger Id;
@property (nonatomic,copy) NSString *name;//类型名称

@end

@interface Thumb : MNBaseModel

@property (nonatomic,copy) NSString *raw;//大图地址(已被裁切好了,不用再裁切了,尼玛,人家的UI!!!!!!)
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,copy) NSString *format;//图片类型
@property (nonatomic,assign) NSInteger error_code;

@end

@interface User : MNBaseModel

@property (nonatomic,copy) NSString *avatar_url;//头像地址
@property (nonatomic,copy) NSString *user_id;//作者id
@property (nonatomic,copy) NSString *name;//作者名称
@property (nonatomic,assign) BOOL is_anonymous;

@end

@interface Group : MNBaseModel

@property (nonatomic,copy) NSString *slogan;//标语
@property (nonatomic,copy) NSString *name;//组名称
@property(nonatomic,strong) Thumb *thumb;
@property(nonatomic,strong) Thumb *logo_url_thumb;
@property (nonatomic,assign) NSInteger member_num;
@property(nonatomic,strong) NSString *logo_url;

@end

NS_ASSUME_NONNULL_END

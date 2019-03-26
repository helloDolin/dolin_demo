//
//  RecommendModel.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user":[User class],@"category":[Sort class],@"thumb":[Thumb class],@"pics":[Thumb class],@"album_cover":[Thumb class],@"logo_url_thumb":[Thumb class],@"images":[Thumb class],@"group":[Group class]};
}

@end

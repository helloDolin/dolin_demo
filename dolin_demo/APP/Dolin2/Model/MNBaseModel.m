//
//  MONOModel.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "MNBaseModel.h"
@implementation Sort
@end

@implementation User
@end

@implementation Thumb
@end
@implementation Group
@end

@implementation MNBaseModel
// Model 属性名和 JSON 中的 Key 不相同
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id" : @"id",@"descrip":@"description"};
}

@end

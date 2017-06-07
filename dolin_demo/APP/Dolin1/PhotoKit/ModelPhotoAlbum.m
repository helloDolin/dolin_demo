//
//  ModelPhotoAlbum.m
//  test_ PhotoKit
//
//  Created by dolin on 2017/3/16.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import "ModelPhotoAlbum.h"

@implementation ModelPhotoAlbum

- (NSString *)description {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setValue:_title forKey:@"title"];
    [dic setValue:@(_count) forKey:@"count"];
    [dic setValue:_assetCollection forKey:@"assetCollection 相册集"];
    [dic setValue:_headImageAsset forKey:@"headImageAsset 相册第一张图片缩略图"];
    return [NSString stringWithFormat:@"%@",dic];
}
@end

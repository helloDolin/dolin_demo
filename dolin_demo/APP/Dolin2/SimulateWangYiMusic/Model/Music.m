//
//  WYMusic.m
//  dolin_demo
//
//  Created by dolin on 16/9/2.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Music.h"

@implementation Music

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString: @"id"]) {
        self.musicID = value;
    }
}

@end

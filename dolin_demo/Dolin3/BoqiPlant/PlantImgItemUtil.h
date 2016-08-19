//
//  PlantImgItemUtil.h
//  dolin_demo
//
//  Created by dolin on 16/8/19.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlantImgItemUtil : NSObject
/**
 *  通过图片数组获取item size 数组 的数组
 *  之前将图片item直接放到数组中，现在将高度一样的图片放到数组中再放到数组中（如果以后要改就改 arr1 - 5）
 *
 *
 *  @param imgArr
 *
 *  @return
 */
- (NSArray*)getSizeArrByImgArr:(NSArray*)imgArr;

@end

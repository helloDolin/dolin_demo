//
//  TestUtil.m
//  abinTest
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 dolin. All rights reserved.
//

#import "PlantImgItemUtil.h"
#import "ImageModel.h"
#import <UIKit/UIKit.h>

#define IMG_MAX_HEIGHT (SCREEN_HEIGHT) * 0.25

@implementation PlantImgItemUtil

/**
 *  计算比例
 *
 *  @param fWidth  第一张图片宽
 *  @param fHeight 第一张图片高
 *  @param sWidth  第二张图片宽
 *  @param sHeight 第二张图片高
 *
 *  @return 两张图片的比例 dic格式
 */
- (NSDictionary*)getProportionWithFirstImageWidth:(CGFloat)fWidth
                                           height:(CGFloat)fHeight
                                 secondImageWidth:(CGFloat)sWidth
                                           height:(CGFloat)sHeight {
    CGFloat x = 0;
    CGFloat y = 0;
    // fWidth * x + sWidth * y = SCREEN_WIDTH
    // fHeight * x = sHeight * y
    
    y = SCREEN_WIDTH / (fWidth * (sHeight / fHeight) + sWidth);
    x = sHeight * y / fHeight;
    
    return @{
             @"x":[NSNumber numberWithFloat:x],
             @"y":[NSNumber numberWithFloat:y]
             };
}


/**
 *  判断是否一张图片就直接满足条件
 *  只要不是这种情况其他都认为是不满足条件的
 *
 *  @param img
 *
 *  @return
 */
- (BOOL)isOneImgCanFillItem :(ImageModel*)img {
    CGFloat imgW = img.width;
    CGFloat imgH = img.height;
    if (imgW == SCREEN_WIDTH) {
        if (imgH <= IMG_MAX_HEIGHT) {
            return YES;
        }
    }
    return NO;
}

/**
 *  先用这种笨方法处理
 *
 *  @param f
 *
 *  @return
 */
- (NSString *)formatFloat:(float)f {
    //如果有一位小数点
    if (fmodf(f, 1) == 0) {
        return [NSString stringWithFormat:@"%.0f",f];
    }
    //如果有两位小数点
    else if (fmodf(f*10, 1) == 0) {
        return [NSString stringWithFormat:@"%.1f",f];
    }
    else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

/**
 *  获取精度为2的float数值
 *  针对于（鬼相册）此方法现只控制宽
 *
 *  @param f
 *
 *  @return
 */
- (CGFloat)getPrecisionIs2Float:(CGFloat)f {
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterRoundFloor; // 原值输出
//    NSString* str = [self formatFloat:f];
//    NSNumber* num = [formatter numberFromString:str];
//    return str.floatValue;
    return f - 0.01;
}

/**
 *  通过图片数组获取item size 数组 的数组
 *  之前将图片item直接放到数组中，现在将高度一样的图片放到数组中再放到数组中（如果以后要改就改 arr1 - 5）
 *
 *
 *  @param imgArr
 *
 *  @return
 */
- (NSArray*)getSizeArrByImgArr:(NSArray*)imgArr {
    
    NSMutableArray* sizeArr = [NSMutableArray array];
    
    ImageModel* imgModel = nil;
    ImageModel* aModel = nil;
    ImageModel* bModel = nil;
    
    int mark = 0; //用来记录每一行第一张图在图片数组中的索引
    int number = 0; // 用来记录每一行的图片个数
    
    for (int i = 0 ; i < imgArr.count; i ++) {
        mark = i;
        number = 1; //只要for循环能进来到这一步，就已经有一张图了
        imgModel = imgArr[i];
        // 满足条件直接跳出循环
        if ([self isOneImgCanFillItem:imgModel]) {
            CGSize itemSize = CGSizeMake(imgModel.width, imgModel.height);
            
            NSMutableArray* arr1 = [NSMutableArray array];
            [arr1 addObject:[NSValue valueWithCGSize:itemSize]];
            
            [sizeArr addObject:arr1];
            continue;
        }
        
        // 不满足条件就组合图片宽，直到满足条件
        else {
            aModel = imgArr[i]; // 第一张图片
            
            if (i + 1 < imgArr.count) {
                bModel = imgArr[i + 1]; // 第二张图片
                
                number = 2; //能进入到这里，这一行就已经有两张图了
                NSDictionary* dic = [self getProportionWithFirstImageWidth:aModel.width height:aModel.height secondImageWidth:bModel.width height:bModel.height];
                CGFloat x = [dic[@"x"] floatValue];
                CGFloat y = [dic[@"y"] floatValue];
                
                CGFloat newHeight = aModel.height * x;
                
                // 满足条件
                if (newHeight <= IMG_MAX_HEIGHT) {
                    
                    
                    CGSize itemSize1 = CGSizeMake([self getPrecisionIs2Float:aModel.width * x], newHeight);
                    CGSize itemSize2 = CGSizeMake([self getPrecisionIs2Float:bModel.width * y], newHeight);
                    
                    NSMutableArray* arr2 = [NSMutableArray array];
                    [arr2 addObject:[NSValue valueWithCGSize:itemSize1]];
                    [arr2 addObject:[NSValue valueWithCGSize:itemSize2]];
                    
                    [sizeArr addObject:arr2];
                    
                    i = i + 1;
                    continue;
                }
                
                // 不满足条件就一直循环
                else {
                    // 存储坐标用的arr
                    NSMutableArray* biliDicArr = [NSMutableArray array];
                    [biliDicArr addObject:dic];
                    
                    // 第三张图片下标
                    int j = i + 2;
                    while (newHeight > IMG_MAX_HEIGHT) {
                        CGFloat newW = SCREEN_WIDTH;
                        // to do :判断越界
                        if (j < imgArr.count) {
                            number ++; // 每进入一次这个方法，这一行就会加一张图片
                            imgModel = imgArr[j];
                        } else {
                            //最后一排超过一张图且总图数不够的情况下进这个方法
                            NSMutableArray* arr3 = [NSMutableArray array];
                            for (int d = mark; d < mark + number; d ++) {
                                imgModel = imgArr[d];
                                //最后一排图片不够了才会进入这个方法所以说让最后一排的图片高度都为规定的最大图片高度IMG_MAX_HEIGHT即可
                                CGSize size = CGSizeMake([self getPrecisionIs2Float: imgModel.width * (IMG_MAX_HEIGHT/imgModel.height)], IMG_MAX_HEIGHT);
                                [arr3 addObject:[NSValue valueWithCGSize:size]];
                            }
                            [sizeArr addObject:arr3];
                            return sizeArr;
                        }
                        
                        NSDictionary* newDic = [self getProportionWithFirstImageWidth:newW height:newHeight secondImageWidth:imgModel.width height:imgModel.height];
                        
                        [biliDicArr addObject:newDic];
                        
                        CGFloat newY = [newDic[@"y"] floatValue];
                        newHeight = imgModel.height * newY;
                        j++;
                    }
                    
                    NSMutableArray* biliArr = [NSMutableArray array];    // 最终的比例arr
                    NSMutableArray* finalBiliArr = [NSMutableArray array];
                    for (int a = 0; a < biliDicArr.count; a++) {
                        NSDictionary* biliDic1 = biliDicArr[a];
                        if (a == 0) {
                            [biliArr addObject:biliDic1[@"x"]];
                            [biliArr addObject:biliDic1[@"y"]];
                        }else {
                            for (int b = 0; b < biliArr.count; b ++) {
                                float biliArrOfNum = [biliArr[b] floatValue];
                                float finalBiliNum = [biliDic1[@"x"] floatValue] * biliArrOfNum;
                                [finalBiliArr addObject:[NSNumber numberWithFloat:finalBiliNum]];
                            }
                            [finalBiliArr addObject:biliDic1[@"y"]];
                            biliArr = [finalBiliArr mutableCopy];
                            [finalBiliArr removeAllObjects];
                        }
                    }
                    
                    // 已经获取所有正确比例
                    int biliArrIndex = 0; // biliArr 每一轮都会清空所以说每一轮都从0开始
                    
                    NSMutableArray* arr4 = [NSMutableArray array];
                    for (int c = mark; c < j ; c ++) {
                        if (c < imgArr.count) {
                            imgModel = imgArr[c];
                            CGSize finalSize = CGSizeMake([self getPrecisionIs2Float:imgModel.width * [biliArr[biliArrIndex] floatValue]], imgModel.height * [biliArr[biliArrIndex] floatValue]);
                            biliArrIndex ++;
                            [arr4 addObject:[NSValue valueWithCGSize:finalSize]];
                            i = j - 1; //j是本轮最后一张图的索引，因此要将j的值赋给i，下一轮的第一张图片就能从j＋1也就是i＋1开始了
                        } else {
                            break;
                        }
                    }
                    
                    [sizeArr addObject:arr4];
                }
            }
            else {
                // 最后一张图的处理
                // 先让图片的高度为IMG_MAX_HEIGHT
                imgModel = imgArr[mark];
                CGFloat x = IMG_MAX_HEIGHT / imgModel.height;
                //如果在这个比例下图片的宽度仍然超出屏幕宽度，那么就已图片的宽度为 屏幕宽度减去两边间隙
                if ((imgModel.width * x) > SCREEN_WIDTH) {
                    x = SCREEN_WIDTH / imgModel.width;
                }
                CGSize size = CGSizeMake([self getPrecisionIs2Float:imgModel.width * x], imgModel.height * x);
                NSArray* arr5 = [NSArray arrayWithObject:[NSValue valueWithCGSize:size]];
                [sizeArr addObject:arr5];
            }
        }
    }
    return sizeArr;
}


@end

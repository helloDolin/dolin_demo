//
//  CreatQRCodeAndBarCodeFromLeon.h
//  sadasda
//
//  Created by 李政 on 15/9/22.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CreatQRCodeAndBarCodeFromLeon : NSObject
/**
 *  二维码生成(Erica Sadun 原生代码生成)
 *
 *  @param string   内容字符串
 *  @param size 二维码大小
 *  @param color 二维码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;
/**
 *  条形码生成(Third party)
 *
 *  @param code   内容字符串
 *  @param size  条形码大小
 *  @param color 条形码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;
@end

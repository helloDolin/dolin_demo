//
//  UIImage+DLRoundImg.m
//  RoundImg
//
//  Created by dolin on 16/12/16.
//  Copyright © 2016年 dolin. All rights reserved.
//

#import "UIImage+DLRoundImg.h"

@implementation UIImage (DLRoundImg)

- (UIImage*)dl_roundImgBySize:(CGSize)size
                      bgColor:(UIColor*)bgColor
                  borderColor:(UIColor*)borderColor
                  borderWidth:(CGFloat)borderWidth {
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    NSAssert(width == height, @"rect 的宽高应该相同");
    // 背景rect
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // 要截的rect
    CGRect clipRect = CGRectMake(borderWidth, borderWidth, width - borderWidth*2, height - borderWidth*2);
    
    // 圆角半径
    CGFloat radius = (width - borderWidth) / 2;
    
    // 开启上下文
    // opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    // scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    
    
    
    // 填充背景色
    [bgColor setFill];
    UIRectFill(rect);
    
    // 设置边框颜色
    UIBezierPath* borderPath = [UIBezierPath bezierPathWithOvalInRect:clipRect];
    [borderColor setStroke];
    borderPath.lineWidth = borderWidth;
    [borderPath stroke];
    
    // 设置裁剪区域
    UIBezierPath* clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    // 剪裁
    [clipPath addClip];
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获取新图片
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return img;

}
@end

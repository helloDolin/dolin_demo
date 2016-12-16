//
//  UIImage+DLRoundImg.h
//  RoundImg
//
//  Created by dolin on 16/12/16.
//  Copyright © 2016年 dolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DLRoundImg)

/**
*  imageView需要是正方形的
*
*  @param size        imgView的size
*  @param bgColor     背景色
*  @param borderColor 边框色
*  @param borderWidth 边框宽度
*
*  @return 圆形img
*/
- (UIImage*)dl_roundImgBySize:(CGSize)size
                      bgColor:(UIColor*)bgColor
                  borderColor:(UIColor*)borderColor
                  borderWidth:(CGFloat)borderWidth;
@end

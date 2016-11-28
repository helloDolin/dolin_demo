//
//  DolinLabel.h
//  dolin_demo
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义各种间距还可以点击复制
 *  有空研究<CoreText/CoreText.h>
 */
@interface DolinLabel : UILabel

@property(nonatomic,assign) CGFloat characterSpacing; // 字间距
@property(nonatomic,assign) CGFloat linesSpacing;     // 段间距
@property(nonatomic,assign) CGFloat paragraphSpacing; // 行间距

- (instancetype)initWithCharacterSpacing:(CGFloat)characterSpacing
                            linesSpacing:(CGFloat)linesSpacing
                        paragraphSpacing:(CGFloat)paragraphSpacing;

/*
 * 绘制前获取label高度
 */
- (CGFloat)getAttributedStringHeightByWidthValue:(CGFloat)width;

@end

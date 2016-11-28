//
//  DolinTopWindowUtil.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  iOS10系统添加了这个功能，so此类针对iOS10以前系统有用
 *  点击状态栏回到顶部工具
 *  （为了解决View Controller有多个scrollview导致点击状态栏无法返回的问题）
 *  工厂模式
 */
@interface DolinTopWindowUtil : NSObject

/**
 *  显示window
 */
+ (void)show;

/**
 *  隐藏window
 */
+ (void)hide;

@end

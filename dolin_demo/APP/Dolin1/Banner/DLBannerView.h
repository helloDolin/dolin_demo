//
//  DLBannerView.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/31.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLBannerViewDelegate <NSObject>

- (void)didSelect:(id)data;

@end

/**
 🦍🦍🦍
 核心思想：
 1.利用collectionviewcell的重用机制减少内存开销
 2.items 的 count为数据源个数的1000倍
 3.不断修改cell数据，数据源的index
 4.初始化和滚动到边界位置时，就取消动画滚到中间位置
 */
@interface DLBannerView : UIView

/**
 获取实例

 @param frame
 @param delegate
 @param autoScrollDelay 轮播时间
 @param datas 数据源
 @return 实例
 */
+ (instancetype)dlBannerViewWithFrame:(CGRect)frame delegate:(id<DLBannerViewDelegate>)delegate autoScrollDelay:(NSTimeInterval)autoScrollDelay datas:(NSArray<id>*)datas;

@end

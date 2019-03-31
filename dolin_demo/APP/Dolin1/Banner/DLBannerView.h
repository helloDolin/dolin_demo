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
 核心思想：
 1.利用collectionview的重用cell减少内存开销
 2.（不断修改cell数据）items 的 count为数据源个数的100倍，然后取index的时候进行取余
 3.初始化和滚动到边界位置时，就取消动画滚到中间位置
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

//
//  BannerLayout.h
//  BannerLayout
//
//  Created by dolin on 17/3/8.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*  
 以后扩展
    UICollectionViewScrollDirection
    自动滚动
    无限轮播
 */

/*===========================
 自定义CollectionViewLayout至少需要重写以下方法:
 
 自定义layout最重要的就是算法、算法、还是TMD算法
 
 // 当collectionView的bounds改变的时候是否使当前布局失效以重新布局
 1.shouldInvalidateLayoutForBoundsChange:
 
 // 需要在此方法中返回collectionView的内容大小
 2.collectionViewContentSize
 
 // 为每个Cell返回一个对应的Attributes，我们需要在该Attributes中设置对应的属性，如Frame等
 3.layoutAttributesForItemAtIndexPath:
 
 // 可在此方法中对可见rect中的cell的属性进行相应设置
 4.layoutAttributesForElementsInRect:
 ============================*/

@interface BannerLayout : UICollectionViewLayout

// cell间距
@property (nonatomic, assign) CGFloat spacing;

// cell的尺寸
@property (nonatomic, assign) CGSize itemSize;

// 缩放率
@property (nonatomic, assign) CGFloat scale;

// 边距
@property (nonatomic, assign) UIEdgeInsets edgeInset;


@end

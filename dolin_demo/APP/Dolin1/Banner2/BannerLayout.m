//
//  BannerLayout.m
//  BannerLayout
//
//  Created by dolin on 17/3/8.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import "BannerLayout.h"

@interface BannerLayout()

@property (nonatomic, strong) NSMutableArray *rectAttributes;

@end

@implementation BannerLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self varInit];
    }
    return self;
}


/**
 实例变量的初始化
 */
- (void)varInit {
    self.spacing = 20.0;
    self.itemSize = CGSizeMake(280, 400);
    //self.edgeInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.scale = 1.0;
}

- (CGFloat)getLastItemX {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    return (count - 1) *(self.itemSize.width + self.spacing) - self.edgeInset.left;
}

#pragma mark - override

/**
 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 @param newBounds 新的bounds
 @return bool
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout {
    [super prepareLayout];
}

/**
 目前只考虑一个section的情况
 内容的宽度为: n * （item + space） - space + edge.left + edge.right
 @return ContentSize
 */
- (CGSize)collectionViewContentSize {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = count * (self.itemSize.width + self.spacing) - self.spacing + self.edgeInset.left + self.edgeInset.right;
    CGFloat height = self.collectionView.bounds.size.height;
    return CGSizeMake(width, height);
}

// 该对象包含对应cell外观所需的必要属性，包括center、frame、transform、alpha及其他属性
// 这个主要是给cell设置frame。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = self.itemSize;
    CGFloat x = self.edgeInset.left + indexPath.item * (self.itemSize.width + self.spacing);
    CGFloat y = 0.5 * (self.collectionView.bounds.size.height - self.itemSize.height);
    attribute.frame = CGRectMake(x, y, attribute.size.width, attribute.size.height);
    return attribute;
}

/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 这个banner在此方法中设置缩放效果
 @param rect
 @return
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [self attributesInRect:rect];
    if (self.scale==1) {
        return attributes;
    }
    // 找到屏幕中间的位置
    // NSLog(@"self.collectionView.contentOffset.x = %f",self.collectionView.contentOffset.x);
    CGFloat center = self.collectionView.contentOffset.x + 0.5 * self.collectionView.bounds.size.width;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        // 计算每一个cell离屏幕中间的距离
        CGFloat offset = ABS(attribute.center.x - center);
        NSLog(@"offset = %f",offset);
        CGFloat space = self.itemSize.width + self.spacing;
        
        if (offset < space) {
            CGFloat scale = 1 + (1 - offset / space) * (self.scale -1);
            // 缩放
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
            // 具有较高索引值的项目显示在具有较低值的项目的顶部,zIndex默认为0
            attribute.zIndex = 1;
        }
    }
    return attributes;
}

/**
 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 这个banner设置滚动停止时某一个cell正好在屏幕中间
 在此方法中获取默认情况下停止滚动时离屏幕中间最近的那个cell，并计算两者的距离，将此距离补到proposedContentOffset上即可
 @param proposedContentOffset 建议的偏移量
 @param velocity 速度
 @return
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect oldRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *attributes = [self layoutAttributesForElementsInRect:oldRect];
    CGFloat minOffset = MAXFLOAT;
    CGFloat center = proposedContentOffset.x + 0.5 * self.collectionView.bounds.size.width;
    for (UICollectionViewLayoutAttributes* attribute in attributes) {
        CGFloat offset = attribute.center.x - center;
        if (ABS(offset) < ABS(minOffset)) {
            minOffset = offset;
        }
    }
    CGFloat newX = proposedContentOffset.x + minOffset;
    CGFloat newY = proposedContentOffset.y;
    return CGPointMake(newX, newY);
}


/**
 获取rect内所有的attributes
 */
- (NSArray *)attributesInRect:(CGRect)rect {
    
    NSInteger preIndex = (rect.origin.x - self.edgeInset.left)/(self.itemSize.width + self.spacing);
    preIndex = preIndex < 0 ? 0 : preIndex;
    
    NSInteger latIndex = (CGRectGetMaxX(rect) - self.edgeInset.left) / (self.itemSize.width + self.spacing) ;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    latIndex = latIndex >= itemCount ? itemCount - 1 : latIndex;
    
    [self.rectAttributes removeAllObjects];
    
    for (NSInteger i=preIndex; i<=latIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [self.rectAttributes addObject:attribute];
        }
    }
    return self.rectAttributes;
}

#pragma mark - setter
- (void)setSpacing:(CGFloat)spacing {
    
    if (_spacing != spacing) {
        _spacing = spacing;
        // 使集合视图本身的布局无效并更新布局信息
        [self invalidateLayout];
    }
}

- (void)setItemSize:(CGSize)itemSize {
    if (!CGSizeEqualToSize(_itemSize, itemSize)) {
        _itemSize = itemSize;
        [self invalidateLayout];
    }
}

- (void)setScale:(CGFloat)scale {
    if (_scale != scale) {
        _scale = scale;
        [self invalidateLayout];
    }
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInset, edgeInset)) {
        _edgeInset = edgeInset;
        [self invalidateLayout];
    }
}

#pragma mark - getter
- (NSMutableArray *)rectAttributes {
    if (!_rectAttributes) {
        _rectAttributes = [NSMutableArray array];
    }
    return _rectAttributes;
}

@end

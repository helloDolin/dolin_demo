//
//  Dolin4VC.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin4VC.h"
#import "TitleContainerScrollView.h"
#import "BannerViewController.h"

@interface Dolin4VC ()<UICollectionViewDataSource,UICollectionViewDelegate,TitleContainerScrollViewDelegate>
{
    NSMutableArray<UIViewController*>* _vcs;
}
@property (nonatomic, strong) TitleContainerScrollView *titleContainerScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation Dolin4VC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSArray<NSString*>* arr = @[
                      @"动画相关-Animation_Study_VC",
                      @"UITableViewFDTemplateLayoutCell-FDTemplateVC",
                      @"动画相关-Animation_Study_VC",
                      @"UITableViewFDTemplateLayoutCell-FDTemplateVC",
                      @"动画相关-Animation_Study_VC",
                      @"UITableViewFDTemplateLayoutCell-FDTemplateVC",
                      @"动画相关-Animation_Study_VC",
                      @"UITableViewFDTemplateLayoutCell-FDTemplateVC"
                      ];
    
    
    NSMutableArray* titles = [NSMutableArray array];
    _vcs = [NSMutableArray array];
    
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* title = [obj componentsSeparatedByString:@"-"][0];
        NSString* vcClassName = [obj componentsSeparatedByString:@"-"][1];
        [titles addObject:title];
        [self->_vcs addObject:[[NSClassFromString(vcClassName) alloc] init]];
    }];

    self.titleContainerScrollView.titles = [titles copy];
    
    // 添加子控制器
    // 如果A控制器的View添加到B控制器的View上，那么A控制器一定要成为B控制器的子控制器
    [_vcs enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
    }];
    
    [self.view addSubview:self.titleContainerScrollView];
    [self.view addSubview:self.collectionView];
}

#pragma mark - TitleContainerScrollViewDelegate
//- (UIColor*)colorOfUnderLineInTitleContainerScrollView:(TitleContainerScrollView*)titleContainerScrollView {
//    return [UIColor redColor];
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    if (value < 0) {
        return;
    }
    
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    
    // 防止滑到最右，再滑，数组越界，从而崩溃
    if (rightIndex >= [self.titleContainerScrollView titles].count) {
        rightIndex = [self.titleContainerScrollView titles].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    // 会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    [self.titleContainerScrollView changeStatusByLeftScale:scaleLeft rightScale:scaleRight leftIndex:leftIndex rightIndex:rightIndex];
}

// 滚动减速时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 结束滚动时动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //计算当前控制器View索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.titleContainerScrollView.currentPage = index;
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleContainerScrollView.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // 每次先清空
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController* vc = _vcs[indexPath.item];
    [cell addSubview:vc.view];
    return cell;
}


#pragma mark - getter
- (TitleContainerScrollView*)titleContainerScrollView {
    if (!_titleContainerScrollView) {
        _titleContainerScrollView = [[TitleContainerScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, kTitleContainerScrollViewHeight)];
        _titleContainerScrollView.backgroundColor = RANDOM_UICOLOR;
        [_titleContainerScrollView onceParameterConfig:^(CGFloat *fontSizeNormal, CGFloat *fontSizeSelected, CGFloat *underLineHeight ,UIColor** underLineColor) {
            *fontSizeNormal = 14.0;
            *fontSizeSelected = 16.0;
            *underLineHeight = 2;
            *underLineColor = [UIColor whiteColor];
        }];
        
        _titleContainerScrollView.titleContainerScrollViewDelegate = self;
        
        
        @weakify(self);
        _titleContainerScrollView.buttonClickBlock = ^(NSInteger currentPage) {
            @strongify(self);
            if (!self) {
                return;
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        };
    }
    return _titleContainerScrollView;
}

- (UICollectionView*)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - kTitleContainerScrollViewHeight);
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kTitleContainerScrollViewHeight + NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - kTitleContainerScrollViewHeight - TAB_BAR_HEIGHT) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

@end

//
//  Dolin4ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin4ViewController.h"
#import "TitleContainerScrollView.h"
#import "BannerViewController.h"

@interface Dolin4ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TitleContainerScrollViewDelegate>
{
    NSMutableArray* _vcs;
}
@property (nonatomic, strong) TitleContainerScrollView *titleContainerScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation Dolin4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    NSMutableArray* titles = [@[@"helloworld",@"test2test2",@"test3",@"test4",@"test5",@"test6",@"test7",@"test10test10",@"test9",@"test10test10",@"test6test6"]mutableCopy];
    self.titleContainerScrollView.titles = titles;
    
    _vcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        BannerViewController* vc = [[BannerViewController alloc]init];
        vc.view.backgroundColor = RANDOM_UICOLOR;
        // 注意：如果A控制器的View添加到B控制器的View上，那么A控制器一定要成为B控制器的子控制器。
        [self addChildViewController:vc];
        [_vcs addObject:vc];
    }
    
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
    BannerViewController* vc = _vcs[indexPath.item];
    vc.view.frame = CGRectMake(0 , -64, SCREEN_WIDTH, cell.frame.size.height + 64);
    [cell addSubview:vc.view];
    return cell;
}


#pragma mark - getter
- (TitleContainerScrollView*)titleContainerScrollView {
    if (!_titleContainerScrollView) {
        _titleContainerScrollView = [[TitleContainerScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kTitleContainerScrollViewHeight)];
        _titleContainerScrollView.backgroundColor = [UIColor orangeColor];
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
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:currentPage inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        };
    }
    return _titleContainerScrollView;
}

- (UICollectionView*)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - kTitleContainerScrollViewHeight);
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kTitleContainerScrollViewHeight + 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kTitleContainerScrollViewHeight - 49) collectionViewLayout:layout];
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

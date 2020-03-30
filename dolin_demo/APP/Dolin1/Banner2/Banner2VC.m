//
//  Banner2VC.m
//  dolin_demo
//
//  Created by dolin on 2017/3/9.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "Banner2VC.h"
#import "BannerLayout.h"
#import "YYWeakProxy.h"
#import "Banner2Cell.h"

@interface Banner2VC ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    BannerLayout *_layout;
    NSArray<NSString*> *_datas;
    NSInteger _totalItemsCount;
    NSTimer *_timer;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) int currentIndex;
@end

@implementation Banner2VC

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self varInit];
}

#pragma mark - method
- (void)varInit {
    _datas = @[
               @"http://ws.xzhushou.cn/focusimg/52.jpg",
               @"http://ws.xzhushou.cn/focusimg/51.jpg",
               @"http://ws.xzhushou.cn/focusimg/50.jpg",
               ];
    _totalItemsCount = _datas.count * 100;
    [self p_setupTimer];
}

- (void)p_setupTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }    
}

- (void)p_removeTimer {
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}

- (void)viewWillLayoutSubviews {
    if (self.collectionView.contentOffset.x == 0 && _totalItemsCount) {
        int targetIndex = _totalItemsCount * 0.5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (void)timerAction {
    int targetIndex = self.currentIndex + 1;
    if (targetIndex >= _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        // 末尾到中间位置的滚动取消动画
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}


/**
 根据indexpath.row获取数据数组下标

 @param index indexPath.row
 @return 数据数组下标
 */
- (NSInteger)calculateCurrentIndexByCellIndex:(NSInteger)index {
    return index % _datas.count;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Banner2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner2Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.layer.cornerRadius = 5;
    NSInteger index = [self calculateCurrentIndexByCellIndex:indexPath.row];
    cell.banner_lbl.text = [NSString stringWithFormat:@"%ld",index];
    [cell.banner_imgView sd_setImageWithURL:[NSURL URLWithString:_datas[index]]];
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self p_setupTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_removeTimer];
}

#pragma mark - getter && setter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        _layout = [BannerLayout new];
        _layout.scale = 1.1;
        _layout.itemSize = CGSizeMake(self.view.frame.size.width - 100, self.view.frame.size.height - 500);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [_collectionView registerNib:[UINib nibWithNibName:@"Banner2Cell" bundle:nil] forCellWithReuseIdentifier:@"Banner2Cell"];
    }
    return _collectionView;
}

- (int)currentIndex {
    int index = 0;
    // TODO 硬编码优化
    // +50 因为itemSize宽为self.view.frame.size.width - 100 暂为硬编码
    // +20 因为padding为20 暂为硬编码
    index = (self.collectionView.contentOffset.x + 50) / (_layout.itemSize.width + 20);
    NSLog(@"%d",index);
    return MAX(0,index);
}

@end

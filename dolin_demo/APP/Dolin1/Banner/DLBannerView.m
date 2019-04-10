//
//  DLBannerView.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/31.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "DLBannerView.h"
#import "YYWeakProxy.h"

@interface DLBannerViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView* imgView;
@property(nonatomic,strong)UILabel *lbl;

@end

@interface DLBannerViewCell()

@end

@implementation DLBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    [self addSubview:self.imgView];
    [self addSubview:self.lbl];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(24));
    }];
}

- (UIImageView*)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel*)lbl {
    if (!_lbl) {
        _lbl = [[UILabel alloc]init];
        _lbl.font = [UIFont systemFontOfSize:24 weight:UIFontWeightLight];
        _lbl.textColor = [UIColor blackColor];
    }
    return _lbl;
}

@end



const NSTimeInterval kAutoScrollDelay = 2.0;

@interface DLBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout* _layout;
    // item总个数
    NSInteger _totalItemsCount;
}

@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,copy)NSArray<id>* datas;
@property(nonatomic,strong)NSTimer* timer;
@property(nonatomic,assign)NSTimeInterval autoScrollDelay;
@property(nonatomic,assign)int currentItemIndex;
@property(nonatomic,weak)id<DLBannerViewDelegate> delegate;
@property(nonatomic,strong)UIPageControl* pageControl;

@end

@implementation DLBannerView

+ (instancetype)dlBannerViewWithFrame:(CGRect)frame delegate:(id<DLBannerViewDelegate>)delegate autoScrollDelay:(NSTimeInterval)autoScrollDelay datas:(NSArray<id>*)datas {
    DLBannerView* obj = [[DLBannerView alloc]initWithFrame:frame delegate:delegate autoScrollDelay:autoScrollDelay datas:datas];
    return obj;
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<DLBannerViewDelegate>)delegate autoScrollDelay:(NSTimeInterval)autoScrollDelay datas:(NSArray<id>*)datas {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.autoScrollDelay = autoScrollDelay;
        self.datas = datas;
        [self layoutUI];
        [self p_setUpTimer];
    }
    return self;
}

- (void)layoutUI {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_collectionView.contentOffset.x == 0 && _totalItemsCount) {
        int targetIndex = 0;
        targetIndex = _totalItemsCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DLBannerViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DLBannerViewCell class]) forIndexPath:indexPath];
    
    NSInteger index = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
    
    NSDictionary* dic = self.datas[index];
    NSString* urlStr = dic[@"urlStr"];
    NSString* title = dic[@"title"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    cell.lbl.text = title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
    NSDictionary* dic = self.datas[index];
    [self.delegate didSelect:dic];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = [self pageControlIndexWithCurrentCellIndex:self.currentItemIndex];
    self.pageControl.currentPage = index;
}

- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index {
    return index % self.datas.count;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self p_setUpTimer];
}

- (void)scroll {
    int targetIndex = self.currentItemIndex + 1;
    if (targetIndex >= _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        // 末尾到中间位置的滚动取消动画
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)p_setUpTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.autoScrollDelay target:[YYWeakProxy proxyWithTarget:self] selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)p_removeTimer {
    if (!_timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (UICollectionView*)collectionView {
    if (!_collectionView) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = self.frame.size;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:[DLBannerViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DLBannerViewCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.height - 16,self.width, 8)];
        // 设置页面指示器的颜色
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        // 设置当前页面指示器的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.numberOfPages = self.datas.count;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (int)currentItemIndex {
    int index = 0;
    index = _collectionView.contentOffset.x / _layout.itemSize.width;
    return MAX(0,index);
}

- (void)setDatas:(NSArray<id> *)datas {
    _datas = datas;
    _totalItemsCount = datas.count * 1000;
}

- (void)setAutoScrollDelay:(NSTimeInterval)autoScrollDelay {
    _autoScrollDelay = autoScrollDelay;
    if (autoScrollDelay < 0) {
        _autoScrollDelay = kAutoScrollDelay;
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

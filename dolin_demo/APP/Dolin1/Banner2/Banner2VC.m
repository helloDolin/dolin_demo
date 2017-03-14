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
    CGFloat _currentOffsetX;
    BannerLayout *_layout;
    NSArray<NSString*> *_datas;
    
    NSTimer *_timer;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@end

@implementation Banner2VC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    [self varInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method
- (void)varInit {
    _datas = @[
               @"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",
               @"http://ws.xzhushou.cn/focusimg/52.jpg",
               @"http://ws.xzhushou.cn/focusimg/51.jpg",
               @"http://ws.xzhushou.cn/focusimg/50.jpg",
               @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489732412&di=22a24a46a55e9b29cb8994da8690faea&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.ddvip.com%2FUpload%2F20150811%2F90701439262241.jpg",
               @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137693663&di=763343bc48723a9139c4fce22d781fff&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2Fa32aa58ftw1dvfunkqms4j.jpg"
               ];
    _currentOffsetX = 0;
    [self p_setUpTimer];
}

- (void)p_setUpTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.01 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(timerAction) userInfo:nil repeats:YES];
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

#pragma mark - event
- (void)timerAction {
    [self.collectionView setContentOffset:CGPointMake(_currentOffsetX, 0)];
    ;
    // TODO:这块的处理，待优化
    _currentOffsetX += 1.0;
    CGFloat subNum = _currentOffsetX - [_layout getLastItemX];
    if ( subNum > 0 ) {
        _currentOffsetX = 0;
    }
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Banner2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner2Cell" forIndexPath:indexPath];
    cell.backgroundColor = RANDOM_UICOLOR;
    cell.layer.cornerRadius = 5;
    cell.banner_lbl.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    [cell.banner_imgView sd_setImageWithURL:[NSURL URLWithString:_datas[indexPath.row]]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 根据item中心位置获取当前indexPath
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x + 0.5 * scrollView.bounds.size.width, 0.5 * scrollView.bounds.size.height)];
    if (!indexPath || self.currentIndexPath == indexPath) {
        return;
    }
    self.currentIndexPath = indexPath;
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (decelerate) {
//        _currentOffsetX = scrollView.contentOffset.x;
//        [self p_setUpTimer];
//    }
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentOffsetX = scrollView.contentOffset.x;
    [self p_setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_removeTimer];
}

#pragma mark - getter && setter
- (UICollectionView *)collectionView {
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

#pragma mark - API

#pragma mark - override

@end

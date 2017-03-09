//
//  Banner2VC.m
//  dolin_demo
//
//  Created by dolin on 2017/3/9.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "Banner2VC.h"
#import "BannerLayout.h"

@interface Banner2VC ()<UICollectionViewDataSource, UICollectionViewDelegate>
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

#pragma mark - event

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    cell.backgroundColor = RANDOM_UICOLOR;
    cell.layer.cornerRadius = 5;
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

#pragma mark - getter && setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        BannerLayout *layout = [BannerLayout new];
        layout.scale = 1.1;
        layout.itemSize = CGSizeMake(self.view.frame.size.width - 100, self.view.frame.size.height - 500);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    }
    return _collectionView;
}

#pragma mark - API

#pragma mark - override

@end

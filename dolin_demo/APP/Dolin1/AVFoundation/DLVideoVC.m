//
//  DLVideoVC.m
//  dolin_demo
//
//  Created by dolin on 2017/5/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLVideoVC.h"
#import "DLVideoCell.h"
#import "VideoModel.h"
#import "DLVideoPlayView.h"

@interface DLVideoVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray<VideoModel*> *_data;
    DLVideoPlayView *_dLVideoPlayView;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DLVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    VideoModel* model1 = [VideoModel new];
    model1.imgUrlStr = @"http://vimg3.ws.126.net/image/snapshot/2017/5/M/J/VCIO0D9MJ.jpg";
    model1.videoUrlStr = @"http://flv2.bn.netease.com/videolib3/1705/05/NZQGO9370/SD/NZQGO9370-mobile.mp4";
    
    VideoModel* model2 = [VideoModel new];
    model2.imgUrlStr = @"http://vimg1.ws.126.net/image/snapshot/2017/5/H/T/VCIO1CIHT.jpg";
    model2.videoUrlStr = @"http://flv2.bn.netease.com/videolib3/1705/05/cTwdX9534/SD/cTwdX9534-mobile.mp4";
    
    VideoModel* model3 = [VideoModel new];
    model3.imgUrlStr = @"http://vimg1.ws.126.net/image/snapshot/2017/5/G/Q/VCIO144GQ.jpg";
    model3.videoUrlStr = @"http://flv2.bn.netease.com/tvmrepo/2017/5/A/Q/ECIHP55AQ/SD/ECIHP55AQ-mobile.mp4";
    
    _data = @[model1,model2,model3];
    
    _dLVideoPlayView = [DLVideoPlayView videoPlayView];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DLVideoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DLVideoCell" forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    _dLVideoPlayView.index = indexPath.row;
    VideoModel* model = _data[indexPath.row];
    [_dLVideoPlayView setUrlString:model.videoUrlStr];
    _dLVideoPlayView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT - 200);
    [self.view addSubview:_dLVideoPlayView];
    [_dLVideoPlayView.player play];
    _dLVideoPlayView.hidden = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _dLVideoPlayView.index) {
        [_dLVideoPlayView.player pause];
        _dLVideoPlayView.hidden = YES;
    }
}

#pragma mark - getter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH - 16, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 16);
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT ,SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RANDOM_UICOLOR;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"DLVideoCell" bundle:nil] forCellWithReuseIdentifier:@"DLVideoCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

@end

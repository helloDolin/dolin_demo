//
//  DLPhotoBrowser.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "DLPhotoBrowser.h"
#import "PhotoBrowserCell.h"
#import "UtilOfPhotoAlbum.h"
#import "MBFadeAlertView.h"

static CGFloat const kTopViewHeight = 60.0;
static CGFloat const kBottomViewHeight = 50.0;

@interface DLPhotoBrowser()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger _currentIndex;
    
    UIButton *_cancelBtn;
    UILabel  *_showSelectedNumLbl;
    
    UIButton *_nextBtn;
    UIButton *_checkBtn;
}
// data
@property (nonatomic, assign) NSInteger targetImageIndex;                           // current index
@property (nonatomic, strong) NSMutableArray<PHAsset *> *arrayDataSources;          //
@property (nonatomic, assign) NSInteger maxSelectedCount;
@property (nonatomic, strong) NSMutableArray<ModelSelectedAsset *> *selectedAssets; // selected Assets

// UI
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
//@property (nonatomic, strong) UIActivityIndicatorView *indicator;               // 先注释掉

@end


@implementation DLPhotoBrowser

// dealloc
- (void)dealloc {
    NSLog(@"%s",__func__);
    [self removeObserver:self forKeyPath:@"selectedAssets"];
}

+ (DLPhotoBrowser *)dLPhotoBrowserWithData:(NSMutableArray<PHAsset *> *)arrayDataSources
                            targetImageIndex:(NSInteger)targetImageIndex
                              selectedAssets:(NSMutableArray<ModelSelectedAsset *>*) selectedAssets
                            maxSelectedCount:(NSInteger)maxSelectedCount {
    
    DLPhotoBrowser* browser = [[DLPhotoBrowser alloc]initWithFrame:[UIScreen mainScreen].bounds withArrayDataSources:arrayDataSources];
    browser.targetImageIndex = targetImageIndex;
    browser.selectedAssets = selectedAssets;
    browser.maxSelectedCount = maxSelectedCount;
    // render checkBtn
    PHAsset *asset = arrayDataSources[targetImageIndex];
    [browser renderCheckBtnWithCurrentAssert:asset];
    return browser;

}

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame withArrayDataSources:(NSMutableArray<PHAsset *> *)arrayDataSources;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrayDataSources = [arrayDataSources mutableCopy];
        [self layoutUI];
        [self addObserver:self
               forKeyPath:@"selectedAssets"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];

    }
    return self;
}

#pragma mark - KVO
// 只要selectedAssets发生变化就重新渲染
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self) {
        if ([keyPath isEqualToString:@"selectedAssets"]) {
            [self renderShowSelectedNumLbl];
            _nextBtn.enabled = self.selectedAssets.count >= 1;
        }
    }
}

#pragma mark - method
- (void)renderCellWithHighQuality2Cell:(PhotoBrowserCell*)cell {
    PHAsset *asset = _arrayDataSources[_currentIndex];
    CGFloat scale = [UIScreen mainScreen].scale;
    
    // size 这边有巨坑，size传不同值会导致img为nil，stackOverFlow上怀疑是苹果的bug
    // https://stackoverflow.com/questions/31037859/phimagemanager-requestimageforasset-returns-nil-sometimes-for-icloud-photos#
    
    NSLog(@"%ld",asset.pixelWidth);
    NSLog(@"%ld",asset.pixelHeight);
    NSLog(@"%f",asset.pixelWidth / (float)asset.pixelHeight);
    CGFloat width = MIN(SCREEN_WIDTH, 500);
    CGSize size = CGSizeMake(width * scale, width * scale * asset.pixelHeight / asset.pixelWidth);
    
    if (asset.pixelHeight < 500) {
        size = CGSizeMake(200, 200);
    }
    
    [[UtilOfPhotoAlbum sharedUtilOfPhotoAlbum] requestImageForAsset:asset size:size   completion:^(UIImage *image, NSDictionary *info)  {
        // 高清图
        if (![[info objectForKey:PHImageResultIsDegradedKey] boolValue]) {
            cell.imgView.image = image;
        }
    } iCloudProgress:^(double progress) {
        [SVProgressHUD showProgress:progress];
        if (progress == 1.0) {
            [SVProgressHUD dismiss];
        }
    } ];
}

- (void)renderCheckBtnWithCurrentAssert:(PHAsset*)currentAssert {
    NSString* currentLocalID = currentAssert.localIdentifier;
    __block BOOL isSelected = NO;
    [self.selectedAssets enumerateObjectsUsingBlock:^(ModelSelectedAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.localIdentifier isEqualToString:currentLocalID]) {
            isSelected = YES;
            *stop = YES;
        }
    }];
    _checkBtn.selected = isSelected;
}

- (void)hideTopAndBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        _topView.frame = CGRectMake(0, -kTopViewHeight, SCREEN_WIDTH, 0);
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kBottomViewHeight);
    }];
}

- (void)showTopAndBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight);
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - kBottomViewHeight, SCREEN_WIDTH, kBottomViewHeight);
    }];
}

- (void)addGesture {
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTapGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    // 双点不接受事件
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [self addGestureRecognizer:tapGesture];
}

- (void)layoutUI {
    self.backgroundColor = [UIColor blackColor];
    
    [self addGesture];
    
    [self addSubview:self.collectionView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
//    [self addSubview:self.indicator];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DLPhotoBrowserCell" forIndexPath:indexPath];
    PHAsset *asset = _arrayDataSources[indexPath.row];
    CGFloat scale = .1f;
    CGFloat width = MIN(SCREEN_WIDTH, 500);
    CGSize size = CGSizeMake(width * scale, width * scale * asset.pixelHeight / asset.pixelWidth);
    [[UtilOfPhotoAlbum sharedUtilOfPhotoAlbum] requestImageForAsset:asset size:size completion:^(UIImage *image, NSDictionary *info) {
        cell.imgView.image = image;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoBrowserCell *dLPhotoBrowserCell = (PhotoBrowserCell *)cell;
    [dLPhotoBrowserCell.scrollView setZoomScale:1.0 animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    PHAsset *asset = _arrayDataSources[_currentIndex];
    [self renderCheckBtnWithCurrentAssert:asset];
}

// 仿微信细节
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (PhotoBrowserCell *cell in self.collectionView.visibleCells) {
        [self renderCellWithHighQuality2Cell:cell];
    }
}

#pragma mark - event
- (void)didTapOnView:(UIGestureRecognizer*)gesture {
    if (_topView.frame.origin.y == 0) {
        [self hideTopAndBottomView];
    }
    else {
        [self showTopAndBottomView];
    }
}

// 取消也需要回调选中或未选中的图片（仿微信）
- (void)cancelBtnAction {
    [self.delegate selectedAssets:self.selectedAssets isClickNextBtn:NO];
}


- (void)nextBtnAction {
    [self.delegate selectedAssets:self.selectedAssets isClickNextBtn:YES];
}

- (void)renderShowSelectedNumLbl {
    NSString *selectedCountStr = [NSString stringWithFormat:@"%ld",self.selectedAssets.count];
    _showSelectedNumLbl.text = selectedCountStr;
    _showSelectedNumLbl.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.3 animations:^{
        _showSelectedNumLbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        _showSelectedNumLbl.transform = CGAffineTransformIdentity;
    }];
}

- (void)checkBtnAction:(UIButton*)sender {
    // 校验
    if (self.selectedAssets.count >= self.maxSelectedCount && sender.selected == NO) {
        NSString *tips = [NSString stringWithFormat:@"您最多只能选择%ld张图片", self.maxSelectedCount];
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:tips];
        return;
    }
    // 当前asset
    PHAsset *asset = _arrayDataSources[_currentIndex];
    
    // 当前为选中状态删除此元素
    if (sender.selected) {
        ModelSelectedAsset *selectedAsset = nil;
        for (int i = 0; i < self.selectedAssets.count; i++) {
            selectedAsset = self.selectedAssets[i];
            if ([selectedAsset.localIdentifier isEqualToString:asset.localIdentifier]) {
                [[self mutableArrayValueForKey:@"selectedAssets"] removeObject:selectedAsset];
                break;
            }
        }
    }
    // 当前为未选中状态下添加此元素
    else {
        ModelSelectedAsset *selectedAsset = [ModelSelectedAsset new];
        selectedAsset.localIdentifier = asset.localIdentifier;
        selectedAsset.asset = asset;
        [[self mutableArrayValueForKey:@"selectedAssets"] addObject:selectedAsset];
    }
    
    // 改变状态
    sender.selected = !sender.selected;
}


#pragma mark - setter
- (void)setTargetImageIndex:(NSInteger)targetImageIndex {
    _currentIndex = targetImageIndex;
    [self.collectionView setContentOffset:CGPointMake(targetImageIndex * self.collectionView.bounds.size.width, 0)];
}

#pragma mark - getter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
        layout.minimumLineSpacing = 0 ;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoBrowserCell" bundle:nil] forCellWithReuseIdentifier:@"DLPhotoBrowserCell"];
    }
    return _collectionView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight)];
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _showSelectedNumLbl = [[UILabel alloc]init];
        _showSelectedNumLbl.layer.backgroundColor = RANDOM_UICOLOR.CGColor;
        _showSelectedNumLbl.layer.cornerRadius = 7.5;
        _showSelectedNumLbl.textColor = [UIColor whiteColor];
        _showSelectedNumLbl.text = @"0";
        _showSelectedNumLbl.textAlignment = NSTextAlignmentCenter;
        _showSelectedNumLbl.textColor = [UIColor whiteColor];
        _showSelectedNumLbl.font = [UIFont systemFontOfSize:15];

        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.enabled = NO;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:RANDOM_UICOLOR forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
      
        [_topView addSubview:_cancelBtn];
        [_topView addSubview:_showSelectedNumLbl];
        [_topView addSubview:_nextBtn];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_topView);
            make.left.equalTo(_topView).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, kTopViewHeight));
        }];
        
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_topView).offset(-15);
            make.centerY.equalTo(_topView);
            make.size.mas_equalTo(CGSizeMake(50, kTopViewHeight));
        }];
        
        [_showSelectedNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_nextBtn.titleLabel.mas_left).offset(-5);
            make.centerY.equalTo(_topView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
    }

    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kBottomViewHeight, SCREEN_WIDTH, kBottomViewHeight)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"album_selected"] forState:UIControlStateSelected];
        [_checkBtn setImage:[UIImage imageNamed:@"album_selected"] forState:UIControlStateHighlighted];
        [_checkBtn setImage:[UIImage imageNamed:@"album_unselected"] forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(checkBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        [_bottomView addSubview:_checkBtn];
        
        [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_bottomView).offset(-15);
            make.centerY.equalTo(_bottomView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _bottomView;
}


@end

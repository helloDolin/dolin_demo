//
//  DLPhotoAlbumPickerVC.m
//  dolin_demo
//
//  Created by dolin on 2017/6/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLPhotoAlbumPickerVC.h"
#import "UtilOfPhotoAlbum.h"
#import "PhotoAlbumCell.h"
#import "PhotoAlbumCategoryCell.h"
#import "DLPhotoBrowserVC.h"
#import "PhotoAlbumCameraCell.h"
#import "MBFadeAlertView.h"
#import "SystemPermissionsManager.h"

static const NSInteger kMaxSelectedCount = 9;
static const CGFloat kTableViewCellHeight = 80.0;

@interface DLPhotoAlbumPickerVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,DLPhotoBrowserVCDelegate>
{
    UILabel *_titleLbl;
    UIImageView *_arrowImgView;
    
    UICollectionViewFlowLayout *_layout;
    
    // tableView dataSource
    NSArray<ModelPhotoAlbum*> *_arr_ModelPhotoAlbum;
    
    // 工具单例
    UtilOfPhotoAlbum *_utilOfPhotoAlbum;
    
    // table容器是否显示
    BOOL _isTableContainerViewShow;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *tableContainerView;
// collection dataSource
@property (nonatomic, strong) NSMutableArray<PHAsset *> *arrayDataSources;

@end

@implementation DLPhotoAlbumPickerVC
#pragma mark - life circle
// dealloc
- (void)dealloc {
    NSLog(@"%s",__func__);
    [self removeObserver:self forKeyPath:@"selectedAssets"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // KVO
    [self addObserver:self
           forKeyPath:@"selectedAssets"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    [self instanceVarInit];
    [self layoutUI];
    [self loadDataFromAlbumWithIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitleView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO
// 只要selectedAssets发生变化就重新渲染
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self) {
        if ([keyPath isEqualToString:@"selectedAssets"]) {
//            if (self.selectedAssets.count <= 1) {
//                [self.collectionView reloadData];
//            }
        }
    }
}

#pragma mark - method
- (void)instanceVarInit {
    if (self.maxSelectedCount == 0) {
        self.maxSelectedCount = kMaxSelectedCount;
    }
    _utilOfPhotoAlbum = [UtilOfPhotoAlbum sharedUtilOfPhotoAlbum];
    _arr_ModelPhotoAlbum = [_utilOfPhotoAlbum getPhotoAblumList];
}

- (void)loadDataFromAlbumWithIndex:(NSInteger)index {
    [self.arrayDataSources removeAllObjects];
    ModelPhotoAlbum *model = _arr_ModelPhotoAlbum[index];
    _titleLbl.text = model.title;
    [self.arrayDataSources addObjectsFromArray:[_utilOfPhotoAlbum getAssetsInAssetCollection:model.assetCollection ascending:NO]];
    [self.collectionView reloadData];
}

- (void)layoutUI {
    [self setLeftBarBtn];
    [self setRightBarBtn];
    [self setTitleView];
    
    [self.view addSubview:self.collectionView];
    [self.tableContainerView addSubview:self.tableView];
    [self.view addSubview:self.tableContainerView];
}

// setLeftBarBtnItem
- (void)setLeftBarBtn {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)setRightBarBtn {
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(0, 0, 60, 44);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)setTitleView {
    self.title = @"";
    [self.navigationController.navigationBar addSubview:self.titleView];
}

- (void)removeTitleView {
    [self.titleView removeFromSuperview];
}
/**
 处理被选中的数组
 
 @param isChecked 是否被选中,被选中就删除，未选中就添加
 @param index 下标
 */
- (void)dealSelectedAssetsWithCurrentCheckBtn:(UIButton*)currentCheckBtn index:(NSInteger)index {
    if (self.selectedAssets.count >= self.maxSelectedCount && currentCheckBtn.selected == NO) {
        NSString *tips = [NSString stringWithFormat:@"您最多只能选择%ld张图片", self.maxSelectedCount];
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:tips];
        return;
    }
    
    PHAsset *asset = _arrayDataSources[index];
    // 选中状态下删除此元素
    if (currentCheckBtn.selected) {
        ModelSelectedAsset *selectedAsset = nil;
        for (int i = 0; i < self.selectedAssets.count; i++) {
            selectedAsset = self.selectedAssets[i];
            if ([selectedAsset.localIdentifier isEqualToString:asset.localIdentifier]) {
                [[self mutableArrayValueForKey:@"selectedAssets"] removeObject:selectedAsset];
                break;
            }
        }
    }
    // 未选中状态下添加此元素
    else {
        ModelSelectedAsset *selectedAsset = [ModelSelectedAsset new];
        selectedAsset.localIdentifier = asset.localIdentifier;
        selectedAsset.asset = asset;
        [[self mutableArrayValueForKey:@"selectedAssets"] addObject:selectedAsset];
    }
    currentCheckBtn.selected = !currentCheckBtn.selected;
}

#pragma mark - event
- (void)leftItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnAction {
    NSLog(@"%@",self.selectedAssets);
}

- (void)showTableContainerView {
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat tableViewHeight = _arr_ModelPhotoAlbum.count > 3 ? kTableViewCellHeight * 3 :kTableViewCellHeight*_arr_ModelPhotoAlbum.count;
        self.tableView.height = tableViewHeight;
        self.tableContainerView.alpha = 1;
        _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    _isTableContainerViewShow = YES;
}

- (void)hideTableContainerView {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.height = 0;
        self.tableContainerView.alpha = 0;
        _arrowImgView.transform = CGAffineTransformIdentity;
    }];
    _isTableContainerViewShow = NO;
}

/**
 打开照相机
 */
- (void)presentImgPickerVC {
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = NO;
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)tapTitleView {
    if (!_isTableContainerViewShow) {
        [self showTableContainerView];
    } else {
        [self hideTableContainerView];
    }
}

- (void)tapGesAction {
    [self hideTableContainerView];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr_ModelPhotoAlbum.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoAlbumCategoryCell *cell = [PhotoAlbumCategoryCell cellWithTableView:tableView];
    ModelPhotoAlbum *model = _arr_ModelPhotoAlbum[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    [self loadDataFromAlbumWithIndex:index];
    [self hideTableContainerView];
}

#pragma mark - UICollectionViewDataSource UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // +1:为了第一个item显示拍照
    return _arrayDataSources.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PhotoAlbumCameraCell* photoAlbumCameraCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoAlbumCameraCell" forIndexPath:indexPath];
        photoAlbumCameraCell.imgView.image = [UIImage imageNamed:@"album_icon_camera"];
        return photoAlbumCameraCell;
    }
    else {
        PhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoAlbumCell" forIndexPath:indexPath];
        // 全部置为未选中，下面根据数据去render checkBtn
        cell.checkBtn.selected = NO;
        
        NSInteger index = indexPath.row - 1;
        PHAsset *asset = _arrayDataSources[index];
        CGSize size = CGSizeMake(_layout.itemSize.width * 2,_layout.itemSize.height * 2);
        
        [_utilOfPhotoAlbum requestImageForAsset:asset size:size completion:^(UIImage *image, NSDictionary *info) {
            cell.imgView.image = image;
        }];
        
        // render checkBtn
        for (ModelSelectedAsset *model in self.selectedAssets) {
            if ([model.localIdentifier isEqualToString:asset.localIdentifier]) {
                cell.checkBtn.selected = YES;
                break;
            }
        }
        
        // 选中按钮回调
        WS(weakSelf);
        cell.checkBtnBlock = ^(UIButton* currentBtn) {
            [weakSelf dealSelectedAssetsWithCurrentCheckBtn:currentBtn index:index];
        };
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 拍照
    if (indexPath.row == 0) {
        // 权限处理
        if(![SystemPermissionsManager requestAuthorization:SystemPermissions_AVMediaTypeVideo withSureBtnClickBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentImgPickerVC];
            });
        }])
        {
            return;
        }
        [self presentImgPickerVC];
    }
    // 预览
    else {
        NSInteger index = indexPath.row - 1;
        DLPhotoBrowserVC* vc = [DLPhotoBrowserVC new];
        vc.arrayDataSources = _arrayDataSources;
        vc.targetImageIndex = index;
        vc.selectedAssets = self.selectedAssets;
        vc.maxSelectedCount = self.maxSelectedCount;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        // 返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

#pragma mark - DLPhotoBrowserVCDelegate
- (void)selectedAssets:(NSMutableArray<ModelSelectedAsset *> *)selectedAssets isClickNextBtn:(BOOL)isClickNextBtn {
    self.selectedAssets = selectedAssets;
    [self.collectionView reloadData];
}

#pragma mark - getter
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH - 120, 44)];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleView)];
        [_titleView addGestureRecognizer:gestureRecognizer];
        
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.font = [UIFont systemFontOfSize:17];
        _titleLbl.textColor = [UIColor whiteColor];
        _arrowImgView = [[UIImageView alloc]init];
        _arrowImgView.image = [UIImage imageNamed:@"arrow_down"];
        
        [_titleView addSubview:_titleLbl];
        [_titleView addSubview:_arrowImgView];
        
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_titleView);
            make.top.equalTo(_titleView);
            make.bottom.equalTo(_titleView);
        }];
        
        [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(12, 6));
            make.centerY.equalTo(_titleLbl.mas_centerY);
            make.left.equalTo(_titleLbl.mas_right).offset(5);
        }];
        
    }
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kTableViewCellHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DLPhotoAlbumPickerVC"];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat cellWidth = (SCREEN_WIDTH - 8 * 4) / 3;
        CGSize itemSize = CGSizeMake(cellWidth, cellWidth);
        _layout.itemSize = itemSize;
        _layout.minimumLineSpacing = 8;
        _layout.minimumInteritemSpacing = 8;
        _layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:_layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoAlbumCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoAlbumCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoAlbumCameraCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoAlbumCameraCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UIView*)tableContainerView {
    if (!_tableContainerView) {
        _tableContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableContainerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesAction)];
        [_tableContainerView addGestureRecognizer:tapGes];
        tapGes.delegate = self;
        _tableContainerView.clipsToBounds = YES;
        _tableContainerView.alpha = 0;
    }
    return _tableContainerView;
}

- (NSMutableArray *)arrayDataSources {
    if (!_arrayDataSources) {
        _arrayDataSources = [NSMutableArray array];
    }
    return _arrayDataSources;
}

- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}

@end

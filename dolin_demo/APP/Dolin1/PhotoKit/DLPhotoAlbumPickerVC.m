//
//  DLPhotoAlbumPickerVC.m
//  dolin_demo
//
//  Created by dolin on 2017/6/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLPhotoAlbumPickerVC.h"
#import "UtilOfPhotoAlbum.h"
//#import "PhotoAlbumCell.h"
//#import "SystemPermissionsManager.h"
#import "PhotoAlbumCategoryCell.h"
//#import "DLPhotoBrowser.h"
//#import "DLPhotoBrowserVC.h"
//#import "PhotoAlbumCameraCell.h"

static const NSInteger kMaxSelectedCount = 9;
static const CGFloat kTableViewCellHeight = 80.0;

@interface DLPhotoAlbumPickerVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//    [self.view addSubview:self.collectionView];
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
    nextBtn.frame = CGRectMake(0, 0, 120, 44);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)setTitleView {
    self.navigationItem.titleView = self.titleView;
}

#pragma mark - event
- (void)leftItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnAction {
    NSLog(@"nextBtnAction");
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


#pragma mark - getter
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH - 120, 44)];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleView)];
        [_titleView addGestureRecognizer:gestureRecognizer];
        
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.font = [UIFont systemFontOfSize:17];
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

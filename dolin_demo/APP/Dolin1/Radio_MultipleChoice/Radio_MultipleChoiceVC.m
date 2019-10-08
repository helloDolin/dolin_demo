//
//  Radio_MultipleChoiceVC.m
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "Radio_MultipleChoiceVC.h"
#import "TestCollectionCell.h"
#import "TestHeader.h"
#import "TestModel.h"
#import "TestFooter.h"

@interface Radio_MultipleChoiceVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) NSArray *data;

@end

static const CGFloat kLineSpacing = 10.0;
static const CGFloat kItemSpacing = 20.0;
static const CGFloat kSectionPadding = 10.0;


@implementation Radio_MultipleChoiceVC

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionView.y = NAVIGATION_BAR_HEIGHT + 100;
    }];
}

#pragma mark - Setup View / Data

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.btn];
}

- (void)setupData {
    TestModel *model11 = [TestModel testModelWithTitle:@"11" isSelected:NO];
    TestModel *model12 = [TestModel testModelWithTitle:@"12" isSelected:NO];
    TestModel *model13 = [TestModel testModelWithTitle:@"13" isSelected:NO];
    TestModel *model14 = [TestModel testModelWithTitle:@"14" isSelected:NO];
    
    TestModel *model21 = [TestModel testModelWithTitle:@"21" isSelected:NO];
    TestModel *model22 = [TestModel testModelWithTitle:@"22" isSelected:NO];
    
    TestModel *model31 = [TestModel testModelWithTitle:@"31" isSelected:NO];
    TestModel *model32 = [TestModel testModelWithTitle:@"32" isSelected:NO];
    TestModel *model33 = [TestModel testModelWithTitle:@"33" isSelected:NO];
    TestModel *model34 = [TestModel testModelWithTitle:@"34" isSelected:NO];
    
    
    _data = @[
              @[model11,model12,model13,model14],
              @[model21,model22],
              @[model31,model32,model33,model34],
              ];
}

#pragma mark - Observer

#pragma mark - Notification

#pragma mark - Event Response
- (void)buttonTap:(UIButton*)btn {
    [self getSelectedData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Override Methods

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return ((NSArray*)_data[0]).count;
    } else if (section == 1){
        return ((NSArray*)_data[1]).count;
    }
    return ((NSArray*)_data[2]).count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionCell" forIndexPath:indexPath];
    TestModel *model = _data[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TestHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TestHeader" forIndexPath:indexPath];
        header.headerLbl.text = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
        return header;
    }
    TestFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TestFooter" forIndexPath:indexPath];
    return footer;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 单选实现方案
    [self changeDataAndReload:indexPath];
    
    // 多选实现方案
    //    TestModel *model = _data[indexPath.section][indexPath.row];
    //    model.isSelected = !model.isSelected;
    //    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return CGSizeMake(collectionView.bounds.size.width, 20);
//    } else if (section == 1) {
//        return CGSizeMake(collectionView.bounds.size.width, 40);
//    }
//    return CGSizeMake(collectionView.bounds.size.width, 60);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    CGFloat width = collectionView.width;
    NSInteger rowCount = 3; // 每行item个数
    CGFloat itemWidth = (width - kSectionPadding * 2 - kItemSpacing * (rowCount - 1) - 1) / rowCount;
    switch (indexPath.section) {
        case 0:
            size = CGSizeMake(itemWidth, itemWidth);
            break;
        case 1:
            size = CGSizeMake(itemWidth, 50);
            break;
        case 2:
            size = CGSizeMake(itemWidth, 100);
            break;
        default:
            break;
    }
    return size;
}


#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)getSelectedData {
    [_data enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(TestModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected == YES) {
                NSLog(@"%@",obj.title);
            }
        }];
    }];
}

- (void)changeDataAndReload:(NSIndexPath *)indexPath {
    NSArray<TestModel*> *arr = _data[indexPath.section];
    NSInteger index = indexPath.row;
    [arr enumerateObjectsUsingBlock:^(TestModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            obj.isSelected = !obj.isSelected;
        } else {
            obj.isSelected = NO;
        }
    }];
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}

#pragma mark - Setter / Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = kLineSpacing;
        layout.minimumInteritemSpacing = kItemSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(kSectionPadding, kSectionPadding, kSectionPadding, kSectionPadding);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40); // 这个宽度随便设，都是collectionview宽
        layout.footerReferenceSize = CGSizeMake(1, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 200) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TestCollectionCell class] forCellWithReuseIdentifier:@"TestCollectionCell"];
        [_collectionView registerClass:[TestHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TestHeader"];
        [_collectionView registerClass:[TestFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TestFooter"];
        //        _collectionView.allowsMultipleSelection = YES;
    }
    return _collectionView;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);
        _btn.backgroundColor = RANDOM_UICOLOR;
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitle:@"dismiss" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark - Network




@end

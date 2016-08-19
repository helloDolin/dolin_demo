//
//  Dolin3ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin3ViewController.h"
#import "ImageModel.h"
#import "PlantImgItemUtil.h"
#import "PlantCollectionViewCell.h"


@interface Dolin3ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray* _sizeArr;
}

@property (nonatomic,strong)UICollectionView* collectionView;


@end

@implementation Dolin3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RANDOM_UICOLOR;
    
    NSMutableArray* imgArr = [NSMutableArray array];
    ImageModel * img = nil;
    for (int i = 0 ; i < 10; i ++) {
        img = [ImageModel new];
        img.width = arc4random() % 500 + 100;
        img.height = arc4random() % 500 + 100;
        [imgArr addObject:img];
    }
    
    
    PlantImgItemUtil* util = [PlantImgItemUtil new];
    _sizeArr = [util getSizeArrByImgArr:imgArr];
    [self.view addSubview:self.collectionView];
}

#pragma mark -  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sizeArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray* arr = _sizeArr[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlantCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlantCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.backgroundColor = RANDOM_UICOLOR;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSValue* value = _sizeArr[indexPath.section][indexPath.row];
    CGSize size =  [value CGSizeValue];
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 0, 2, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark -  getter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT - 64) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"PlantCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PlantCollectionViewCell"];
    }
    return _collectionView;
}


@end

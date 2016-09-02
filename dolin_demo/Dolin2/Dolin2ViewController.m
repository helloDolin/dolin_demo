//
//  Dolin2ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin2ViewController.h"
#import "Dolin2CollectionViewCell.h"
#import "ExpandClickAreaButton.h"

static  NSString* cellReuseIdentifier = @"cellReuseIdentifier";

@interface Dolin2ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray* _arrDataSource;
}

@property (nonatomic,strong)UICollectionView* collectionView;


@end

// 可以定义多个匿名类别，扩展
@interface Dolin2ViewController ()

@property (nonatomic,strong)NSMutableArray* testArray;

@end

@implementation Dolin2ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    ExpandClickAreaButton* btn = [ExpandClickAreaButton buttonWithType:UIButtonTypeSystem];
    CGFloat btnWidth = 50;
    CGFloat btnHeight = 50;
    btn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    btn.frame = CGRectMake((SCREEN_WIDTH - btnWidth) / 2, 64 + 20, btnWidth, btnHeight);
    [btn setImage:[UIImage imageNamed:@"btn_like"] forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    
    
    [self.view addSubview:btn];
    
//    _arrDataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
//    [self.view addSubview:self.collectionView];
}

- (void)btnAction {
    NSLog(@"btnAction");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _arrDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Dolin2CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    NSString* str = _arrDataSource[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:str];
    cell.titleLbl.text = str;
    return cell;
}


#pragma mark -  getter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemW = (SCREEN_WIDTH - 20 * 3) / 2;
        CGFloat itemH = itemW;
        
        layout.itemSize = CGSizeMake(itemW,itemH);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:FULL_SCREEN_FRAME collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"Dolin2CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellReuseIdentifier];
    }
    return _collectionView;
}



@end

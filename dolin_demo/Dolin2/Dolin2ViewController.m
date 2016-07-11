//
//  Dolin2ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin2ViewController.h"
#import "Dolin2CollectionViewCell.h"

static  NSString* cellReuseIdentifier = @"cellReuseIdentifier";

@interface Dolin2ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray* _arrDataSource;
}

@property (nonatomic,strong)UICollectionView* collectionView;


@end

@implementation Dolin2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arrDataSource = @[@1,@2,@1,@2,@1,@2,@1,@2,@1,@2,@1,@2,@1];
    [self.view addSubview:self.collectionView];
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
    return cell;
}


#pragma mark -  getter
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat padding = 20.0;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - padding ) / 2;
        CGFloat height = 97;
        layout.itemSize = CGSizeMake(width,height);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:FULL_SCREEN_FRAME collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"Dolin2CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellReuseIdentifier];
    }
    return _collectionView;
}



@end

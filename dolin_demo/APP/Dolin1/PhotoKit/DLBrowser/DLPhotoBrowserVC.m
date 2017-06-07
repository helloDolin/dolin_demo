//
//  DLPhotoBrowserVC.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/27.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "DLPhotoBrowserVC.h"
#import "DLPhotoBrowser.h"
#import "PhotoBrowserCell.h"

@interface DLPhotoBrowserVC ()<DLPhotoBrowserDelegate>

@property (nonatomic, strong) DLPhotoBrowser *dLPhotoBrowser;

@end

@implementation DLPhotoBrowserVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dLPhotoBrowser = [DLPhotoBrowser dLPhotoBrowserWithData:self.arrayDataSources targetImageIndex:self.targetImageIndex selectedAssets:self.selectedAssets maxSelectedCount:self.maxSelectedCount];
    self.dLPhotoBrowser.delegate = self;
    [self.view addSubview:self.dLPhotoBrowser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PhotoBrowserCell *cell = (PhotoBrowserCell*)[self.dLPhotoBrowser.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.targetImageIndex inSection:0]];
    [self.dLPhotoBrowser renderCellWithHighQuality2Cell:cell];
}

#pragma mark - method

#pragma mark - event

#pragma mark - DLPhotoBrowserDelegate
- (void)selectedAssets:(NSMutableArray<ModelSelectedAsset *> *)selectedAssets isClickNextBtn:(BOOL)isClickNextBtn {
    self.selectedAssets = selectedAssets;
    [self.delegate selectedAssets:selectedAssets isClickNextBtn:isClickNextBtn];
    if (isClickNextBtn) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.selectedAssets forKey:@"selectedAssets"];
        // TODO:
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - getter && setter

#pragma mark - API


@end

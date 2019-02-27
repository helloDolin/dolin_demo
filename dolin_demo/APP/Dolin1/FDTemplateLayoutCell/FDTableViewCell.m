//
//  FDTableViewCell.m
//  dolin_demo
//
//  Created by Dolin on 2019/2/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "FDTableViewCell.h"
#import "FDPhotoCell.h"
@interface FDTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation FDTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView {
    static NSString* ID = @"FDTableViewCell";
    FDTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FDTableViewCell" owner:0 options:nil][0];
    }
    [tableView registerNib:[UINib nibWithNibName:@"FDTableViewCell" bundle:nil] forCellReuseIdentifier:@"FDTableViewCell"];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoContainer.dataSource = self;
    self.photoContainer.delegate = self;
    self.photoContainer.scrollEnabled = NO;
    [self.photoContainer registerClass:[FDPhotoCell class] forCellWithReuseIdentifier:@"FDPhotoCell"];
}

#pragma mark - colletionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FDPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FDPhotoCell" forIndexPath:indexPath];
    NSURL* url = [NSURL URLWithString:[_model.urls[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [cell.imgView sd_setImageWithURL:url];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = SCREEN_WIDTH - 40 - 20;
    if (self.model.urls.count != 0) {
        if (self.model.urls.count == 1) {
            return CGSizeMake(width / 2, width / 1.5);
        }
        else {
            return CGSizeMake(width / 3.0, width / 3.0);
        }
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FDCellModel *)model {
    _model = model;
    NSURL* url = [NSURL URLWithString:[_model.userIconUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.userIcon sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    self.userName.text = _model.userName;
    self.shuoshuo.text = _model.shuoshuo;
    
    CGFloat width = SCREEN_WIDTH - 40 - 20;
    
    if (_model.urls.count == 0) {
        self.photoContainerHeight.constant = 0;
    }
    else if (_model.urls.count == 1) {
        self.photoContainerHeight.constant = width / 1.5 + 20;
    }
    else {
        NSInteger count = _model.urls.count;
        float perHeight = (width / 3);
        float padding = 10.0;
        CGFloat height = ((count - 1) / 3 + 1) * perHeight  + (count - 1) / 3 * padding + 20;
        self.photoContainerHeight.constant = height;
    }
    
}


@end

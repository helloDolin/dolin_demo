//
//  PhotoAlbumCategoryCell.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelPhotoAlbum.h"

@interface PhotoAlbumCategoryCell : UITableViewCell

@property (nonatomic, strong) ModelPhotoAlbum *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

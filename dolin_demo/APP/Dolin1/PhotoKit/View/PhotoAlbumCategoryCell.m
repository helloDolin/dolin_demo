//
//  PhotoAlbumCategoryCell.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "PhotoAlbumCategoryCell.h"
#import "UtilOfPhotoAlbum.h"

@implementation PhotoAlbumCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"PhotoAlbumCategoryCell";
    PhotoAlbumCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PhotoAlbumCategoryCell" owner:0 options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(ModelPhotoAlbum *)model {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = CGSizeMake(self.imgView.width * scale,self.imgView.height * scale);
    _model = model;
    [[UtilOfPhotoAlbum sharedUtilOfPhotoAlbum] requestImageForAsset:_model.headImageAsset size:size  completion:^(UIImage *image, NSDictionary *info) {
        self.imgView.image = image;
    }];
    self.titleLabel.text = _model.title;
    self.photoCountLabel.text = [NSString stringWithFormat:@"%ld", _model.count];
}

@end

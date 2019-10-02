//
//  PhotoAlbumCell.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/17.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "PhotoAlbumCell.h"

@implementation PhotoAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)checkBtnAction:(UIButton *)sender {
    if (self.checkBtnBlock) {
        self.checkBtnBlock(sender);
    }
}

@end

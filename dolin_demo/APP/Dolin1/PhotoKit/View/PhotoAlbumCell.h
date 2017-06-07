//
//  PhotoAlbumCell.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/17.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelSelectedAsset.h"

typedef void(^CheckBtnBlock)(UIButton* currentBtn);

@interface PhotoAlbumCell : UICollectionViewCell

@property (nonatomic, copy) CheckBtnBlock checkBtnBlock;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

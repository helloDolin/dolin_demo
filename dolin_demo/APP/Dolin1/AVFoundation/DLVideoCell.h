//
//  DLVideoCell.h
//  dolin_demo
//
//  Created by dolin on 2017/5/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface DLVideoCell : UICollectionViewCell

@property (nonatomic, strong) VideoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@end

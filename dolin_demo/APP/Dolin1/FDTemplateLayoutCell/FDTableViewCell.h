//
//  FDTableViewCell.h
//  dolin_demo
//
//  Created by Dolin on 2019/2/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCellModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface FDTableViewCell : UITableViewCell

@property(nonatomic,strong)FDCellModel* model;

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *shuoshuo;
@property (weak, nonatomic) IBOutlet UICollectionView *photoContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoContainerHeight;

+ (instancetype)cellWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END

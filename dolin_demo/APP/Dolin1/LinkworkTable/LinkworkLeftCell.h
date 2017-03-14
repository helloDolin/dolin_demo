//
//  LinkworkLeftCell.h
//  dolin_demo
//
//  Created by dolin on 2017/3/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkworkLeftCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

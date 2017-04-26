//
//  SmokeRememberCell.h
//  dolin_demo
//
//  Created by dolin on 2017/4/26.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmokeRememberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

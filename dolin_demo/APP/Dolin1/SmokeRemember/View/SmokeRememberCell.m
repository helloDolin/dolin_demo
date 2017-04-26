//
//  SmokeRememberCell.m
//  dolin_demo
//
//  Created by dolin on 2017/4/26.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "SmokeRememberCell.h"

@implementation SmokeRememberCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SmokeRememberCell";
    SmokeRememberCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SmokeRememberCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

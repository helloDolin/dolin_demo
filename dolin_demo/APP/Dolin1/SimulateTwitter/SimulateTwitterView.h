//
//  SimulateTwitterView.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulateTwitterView : UIView

@property (strong, nonatomic) UITableView *tableView;

- (SimulateTwitterView *)initTableViewWithBackgound:(UIImage*)backgroundImage avatarImage:(UIImage *)avatarImage titleString:(NSString *)titleString subtitleString:(NSString *)subtitleString;

@end

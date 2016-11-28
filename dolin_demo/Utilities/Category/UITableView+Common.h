//
//  UITableView+Common.h
//  BoqiiPlant
//
//  Created by zm on 15/7/21.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)

- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;

@end

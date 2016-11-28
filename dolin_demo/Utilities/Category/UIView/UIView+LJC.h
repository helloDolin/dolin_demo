//
//  UIView+LJC.h
//  DemoMasonry
//
//  Created by Ralph Li on 7/1/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  横向或者纵向等间隙的排列一组view
 */
@interface UIView (LJC)

- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end

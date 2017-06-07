//
//  DLPhotoBrowserCell.h
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 DLBrowser 与 IndexBrowser 公用
 */
@interface PhotoBrowserCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end

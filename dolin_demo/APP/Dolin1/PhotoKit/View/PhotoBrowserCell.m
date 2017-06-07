//
//  DLPhotoBrowserCell.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/20.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "PhotoBrowserCell.h"

@interface PhotoBrowserCell()<UIScrollViewDelegate>

@end

@implementation PhotoBrowserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 10.0;
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
}

#pragma mark event
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint pointInView = [tapGesture locationInView:self.scrollView];
    if (self.scrollView.zoomScale > 1.0) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
    else {
        CGFloat newZoomScale = self.scrollView.zoomScale * 2.0f;
        newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
        CGSize scrollViewSize = self.scrollView.bounds.size;
        CGFloat w = scrollViewSize.width / newZoomScale;
        CGFloat h = scrollViewSize.height / newZoomScale;
        CGFloat x = pointInView.x - (w / 2.0f);
        CGFloat y = pointInView.y - (h / 2.0f);
        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
        [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}


@end

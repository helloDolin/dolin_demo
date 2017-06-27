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

- (void)resizeSubviews {
    [_scrollView setZoomScale:1.0 animated:NO];
    UIImage *image = _imgView.image;
    
    if (image.size.height / image.size.width > self.height / self.scrollView.width) {
        _imgView.height = floor(image.size.height / (image.size.width / self.scrollView.width));
    }
    else {
        CGFloat height = image.size.height / image.size.width * self.scrollView.width;
        if (height < 1 || isnan(height)) {
            height = self.height;
        }
        height = floor(height);
        _imgView.height = height;
        _imgView.centerY = self.height / 2;
    }
    
    CGFloat contentSizeH = MAX(_imgView.height, self.height);
    _scrollView.contentSize = CGSizeMake(self.scrollView.width, contentSizeH);
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.bouncesZoom = YES;
    _scrollView.maximumZoomScale = 2.5;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.multipleTouchEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = NO;
    _scrollView.canCancelContentTouches = YES;
    _scrollView.alwaysBounceVertical = NO;
    
    _imgView.frame = CGRectZero;
    _imgView.width = SCREEN_WIDTH;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    
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
        
        CGPoint touchPoint = [tapGesture locationInView:self.imgView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
//        CGFloat newZoomScale = self.scrollView.zoomScale * 2.0f;
//        newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
//        CGSize scrollViewSize = self.scrollView.bounds.size;
//        CGFloat w = scrollViewSize.width / newZoomScale;
//        CGFloat h = scrollViewSize.height / newZoomScale;
//        CGFloat x = pointInView.x - (w / 2.0f);
//        CGFloat y = pointInView.y - (h / 2.0f);
//        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
//        [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}


@end

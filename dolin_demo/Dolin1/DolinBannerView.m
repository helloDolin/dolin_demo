//
//  DolinBannerView.m
//  无线轮播图-少林
//
//  Created by shaolin on 16/7/9.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinBannerView.h"
#import "UIImageView+WebCache.h"

//获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define pageColor RGB(67, 199, 176)

/** 滚动宽度*/
#define ScrollWidth self.frame.size.width
/** 滚动高度*/
#define ScrollHeight self.frame.size.height

static const NSTimeInterval kAutoScrollViewDelay = 3.0; // 延时时间

@interface DolinBannerView()<UIScrollViewDelegate>

@property (nonatomic,copy) NSArray *imageArray;
@property (nonatomic,strong)UIImageView* leftImageView;
@property (nonatomic,strong)UIImageView* centerImageView;
@property (nonatomic,strong)UIImageView* rightImageView;
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger maxImageCount;

@end

@implementation DolinBannerView

#pragma mark -  life circle
- (instancetype)initWithFrame:(CGRect)frame WithInfoArr:(NSArray *)infoArr {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentIndex = 0;
        self.imageArray = [infoArr copy];
        self.maxImageCount = infoArr.count;
        
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.leftImageView];
        [self.scrollView addSubview:self.centerImageView];
        [self.scrollView addSubview:self.rightImageView];
        [self addSubview:self.pageControl];
        
        [self p_changeImageLeft:self.maxImageCount - 1 center:0 right:1];
        
        [self p_setUpTimer];
    }
    return self;
}

-(void)dealloc {
    [self p_removeTimer];
}

#pragma mark -  点击事件
//点击事件
- (void)imageViewDidTap {
    NSNumber* num = [NSNumber numberWithInteger:_currentIndex];
    [self.delegate didSelectBannerViewWithDic:@{@"currentIndex":num}];
}

#pragma mark -  timer事件
- (void)scorll {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +ScrollWidth, 0) animated:YES];
}

#pragma mark -  private method
- (void)p_changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[LeftIndex]] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[centerIndex]] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[rightIndex]] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    
    [self.scrollView setContentOffset:CGPointMake(ScrollWidth, 0)];
}

- (void)p_setUpTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:kAutoScrollViewDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)p_removeTimer {
    if (!_timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)p_changeImageWithOffset:(CGFloat)offsetX {
    if (offsetX >= ScrollWidth * 2) {
        self.currentIndex++;
        if (_currentIndex == _maxImageCount - 1) {
            [self p_changeImageLeft:_currentIndex - 1 center:_currentIndex right:0];
            
        } else if (_currentIndex == _maxImageCount) {
            self.currentIndex = 0;
            [self p_changeImageLeft:_maxImageCount - 1 center:0 right:1];
            
        } else {
            [self p_changeImageLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
        }
        self.pageControl.currentPage = _currentIndex;
    }
    
    if (offsetX <= 0) {
        self.currentIndex--;
        if (_currentIndex == 0) {
            [self p_changeImageLeft:_maxImageCount - 1 center:0 right:1];
            
        } else if (_currentIndex == -1) {
            _currentIndex = _maxImageCount - 1;
            [self p_changeImageLeft:_currentIndex - 1 center:_currentIndex right:0];
        } else {
            [self p_changeImageLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
        }
        self.pageControl.currentPage = _currentIndex;
    }
}

#pragma mark -  UIScrollViewDelegate 
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self p_setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self p_removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self p_changeImageWithOffset:scrollView.contentOffset.x];
}

#pragma mark -  getter
- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(ScrollWidth * 3, 0);
    }
    return _scrollView;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,ScrollHeight - 16,ScrollWidth, 8)];
        //设置页面指示器的颜色
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        //设置当前页面指示器的颜色
        _pageControl.currentPageIndicatorTintColor = pageColor;
        _pageControl.numberOfPages = self.maxImageCount;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UIImageView*)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,ScrollWidth, ScrollHeight)];
    }
    return _leftImageView;
}

- (UIImageView*)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollWidth, 0,ScrollWidth, ScrollHeight)];
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    }
    return _centerImageView;
}

- (UIImageView*)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollWidth * 2, 0,ScrollWidth, ScrollHeight)];
    }
    return _rightImageView;
}

@end

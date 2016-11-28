//
//  SimulateKeepScroll.m
//  dolin_demo
//
//  Created by shaolin on 16/7/15.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SimulateKeepScroll.h"

/** 滚动宽度*/
#define ScrollWidth self.frame.size.width
/** 滚动高度*/
#define ScrollHeight self.frame.size.height
/** label的y坐标*/
#define LABEL_Y ScrollHeight - 16 - 8 - 30

static const NSTimeInterval kAutoScrollViewDelay = 3.0; // 延时时间

@interface SimulateKeepScroll()<UIScrollViewDelegate>
{
    UIColor* _dotColorNormal;
    UIColor* _dotColorCurrent;
}

@property (nonatomic,copy) NSArray *textArray;

@property (nonatomic,strong)UILabel* lblLeft;
@property (nonatomic,strong)UILabel* lblCenter;
@property (nonatomic,strong)UILabel* lblRight;

@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger maxCount;

@end

@implementation SimulateKeepScroll

- (instancetype)initWithFrame:(CGRect)frame
                    WithTexts:(NSArray*)texts
               dotColorNormal:(UIColor*)dotColorNormal
              dotColorCurrent:(UIColor*)dotColorCurrent {
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(texts.count > 1, @"传进来的数组要至少大于一");
        self.currentIndex = 0;
        self.textArray = [texts copy];
        self.maxCount = texts.count;
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.lblLeft];
        [self.scrollView addSubview:self.lblCenter];
        [self.scrollView addSubview:self.lblRight];
        
        _dotColorNormal = dotColorNormal;
        _dotColorCurrent = dotColorCurrent;
        
        [self addSubview:self.pageControl];
        [self p_changeLblLeft:self.maxCount - 1 center:0 right:1];
        
        [self p_setUpTimer];
    }
    return self;
}

-(void)dealloc {
    [self p_removeTimer];
}

- (void)p_changeLblLeft:(NSInteger)leftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
    self.lblLeft.text = self.textArray[leftIndex];
    self.lblCenter.text = self.textArray[centerIndex];
    self.lblRight.text = self.textArray[rightIndex];
    [self.scrollView setContentOffset:CGPointMake(ScrollWidth, 0)];
}

- (void)p_changeTextWithOffset:(CGFloat)offsetX {
    if (offsetX >= ScrollWidth * 2) {
        self.currentIndex++;
        if (_currentIndex == _maxCount - 1) {
            [self p_changeLblLeft:_currentIndex - 1 center:_currentIndex right:0];
            
        } else if (_currentIndex == _maxCount) {
            self.currentIndex = 0;
            [self p_changeLblLeft:_maxCount - 1 center:0 right:1];
            
        } else {
            [self p_changeLblLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
        }
        self.pageControl.currentPage = _currentIndex;
    }
    
    if (offsetX <= 0) {
        self.currentIndex--;
        if (_currentIndex == 0) {
            [self p_changeLblLeft:_maxCount - 1 center:0 right:1];
            
        } else if (_currentIndex == -1) {
            _currentIndex = _maxCount - 1;
            [self p_changeLblLeft:_currentIndex - 1 center:_currentIndex right:0];
        } else {
            [self p_changeLblLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
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
    [self p_changeTextWithOffset:scrollView.contentOffset.x];
}

#pragma mark -  timer事件
- (void)scorll {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + ScrollWidth, 0) animated:YES];
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

#pragma mark -  getter
- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(ScrollWidth * 3, 0);
    }
    return _scrollView;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,ScrollHeight - 16,ScrollWidth, 8)];
        // 设置页面指示器的颜色
        _pageControl.pageIndicatorTintColor = _dotColorNormal;
        // 设置当前页面指示器的颜色
        _pageControl.currentPageIndicatorTintColor = _dotColorCurrent;
        _pageControl.numberOfPages = self.maxCount;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UILabel*)lblLeft {
    if (!_lblLeft) {
        _lblLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, LABEL_Y,ScrollWidth, 30)];
        _lblLeft.textColor = [UIColor whiteColor];
        _lblLeft.textAlignment = NSTextAlignmentCenter;
        _lblLeft.font = [UIFont systemFontOfSize:20];
    }
    return _lblLeft;
}

- (UILabel*)lblCenter {
    if (!_lblCenter) {
        _lblCenter = [[UILabel alloc]initWithFrame:CGRectMake(ScrollWidth, LABEL_Y,ScrollWidth, 30)];
        _lblCenter.textColor = [UIColor whiteColor];
        _lblCenter.textAlignment = NSTextAlignmentCenter;
        _lblCenter.font = [UIFont systemFontOfSize:20];
    }
    return _lblCenter;
}

- (UILabel*)lblRight {
    if (!_lblRight) {
        _lblRight = [[UILabel alloc]initWithFrame:CGRectMake(ScrollWidth * 2, LABEL_Y,ScrollWidth, 30)];
        _lblRight.textColor = [UIColor whiteColor];
        _lblRight.textAlignment = NSTextAlignmentCenter;
        _lblRight.font = [UIFont systemFontOfSize:20];
    }
    return _lblRight;
}


@end

//
//  TestWKWebViewVC.m
//  dolin_demo
//
//  Created by dolin on 16/11/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "TestWKWebViewVC.h"
#import <WebKit/WebKit.h>

@interface TestWKWebViewVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation TestWKWebViewVC

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    NSString* urlStr = @"http://liaoshaolim.github.io/";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [UIView animateWithDuration:0.3 animations:^{
            [_progressView setProgress:_webView.estimatedProgress];
            [_progressView layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            if (_progressView.progress == 1) {
                [_progressView removeFromSuperview];
            };
            
        }];
    }
}


#pragma mark - getter
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView ) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 0)];
        _progressView.progressTintColor = RANDOM_UICOLOR;
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0;
    }
    return _progressView;
}

@end

//
//  ImitateGoodDetailVC.m
//  dolin_demo
//
//  Created by dolin on 17/2/7.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "ImitateGoodDetailVC.h"
#import <WebKit/WebKit.h>
#import "WKDelegateController.h"

@interface ImitateGoodDetailVC ()<UITableViewDataSource,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *noticeLbl;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ImitateGoodDetailVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"senderModel"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.progressView];
    [self.webView addSubview:self.noticeLbl];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:@"https://liaoshaolim.github.io/"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

#pragma mark - event
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"title"]) {
            self.title = self.webView.title;
        }
        
        else if ([keyPath isEqualToString:@"loading"]){
            
        }
        
        else if ([keyPath isEqualToString:@"estimatedProgress"]){
            // estimatedProgress取值范围是0-1;
            [UIView animateWithDuration:0.3 animations:^{
                [_progressView setProgress:_webView.estimatedProgress];
            } completion:^(BOOL finished) {
                if (_progressView.progress == 1) {
                    [_progressView removeFromSuperview];
                };
            }];
        }
        
        if (!self.webView.loading) {
            [UIView animateWithDuration:0.5 animations:^{
                self.progressView.alpha = 0;
            }];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%.2f",scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    self.noticeLbl.alpha = fabs(offsetY)/30;
    if (fabs(offsetY) > 35) {
        self.noticeLbl.text = @"松开,返回商品详情";
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 这里可以通过name处理多组交互
    if ([message.name isEqualToString:@"senderModel"]) {
        //body只支持NSNumber, NSString, NSDate, NSArray,NSDictionary 和 NSNull类型
    }
    
    NSLog(@"===========\nname:%@\nbody:%@\nframeInfo:%@\n===========",message.name,message.body,message.frameInfo);
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImitateGoodDetailVC"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.row == 29) {
        cell.textLabel.text = @"向上滑动，查看全部详情";
    }
    return cell;
}

#pragma mark - getter && setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 2);
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ImitateGoodDetailVC"];
    }
    return _tableView;
}

- (UILabel *)noticeLbl {
    if (!_noticeLbl) {
        _noticeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0,- 30, SCREEN_WIDTH, 30)];
        _noticeLbl.alpha = 0;
        _noticeLbl.textAlignment = NSTextAlignmentCenter;
        _noticeLbl.textColor = RANDOM_UICOLOR;
    }
    return _noticeLbl;
}

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        config.userContentController = [WKUserContentController new];
        
        WKDelegateController * delegateController = [[WKDelegateController alloc]init];
        delegateController.delegate = self;
        [config.userContentController addScriptMessageHandler:delegateController name:@"senderModel"];
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) configuration:config];
        
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        [_webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        [_webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        [_webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
        _webView.scrollView.delegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView ) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0)];
        _progressView.progressTintColor = RANDOM_UICOLOR;
        _progressView.trackTintColor = RANDOM_UICOLOR;//[UIColor clearColor];
    }
    return _progressView;
}

#pragma mark - API

#pragma mark - override

@end

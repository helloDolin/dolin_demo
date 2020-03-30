//
//  TestWebViewVC.m
//  dolin_demo
//
//  Created by dolin on 16/10/28.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "TestWebViewVC.h"
#import "LoadingViewForOC.h"
#import "ImageViewer.h"

@interface TestWebViewVC ()<UIWebViewDelegate>
{
    LoadingViewForOC* _loadingView;
    NSMutableArray* _urlArray;
    ImageViewer *_imgViewer;
    NSInteger _photoIndex;
}

@property(nonatomic,strong)UIWebView* webView;

@end

@implementation TestWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _loadingView = [LoadingViewForOC showLoadingWithWindow];
    _imgViewer = [[ImageViewer alloc] init];
    [self.view addSubview:self.webView];
    NSString* urlStr = @"http://liaoshaolim.github.io/";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"查看图片" style:UIBarButtonItemStylePlain target:self action:@selector(browerPhoto)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - method
- (void)browerPhoto{
    _imgViewer.imageArray = _urlArray;
    _imgViewer.pageControl = YES;
    _imgViewer.index = _photoIndex;
    _imgViewer.block = ^(void) {
        
    };
    [_imgViewer showView:self];

}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
    NSString *urlResult = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _urlArray = [NSMutableArray arrayWithArray:[urlResult componentsSeparatedByString:@"+"]];
    
    // 这边可以对urlArray进行过滤下，只显示该显示的图
    // 点击web图进行跳转的时候，可以拿到url并比对数组获取图片的index
    
    [_loadingView hideLoadingView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* reqStr = request.URL.absoluteString;
    NSString* reqHead = @"http://js2ios//";
    if([reqStr hasPrefix:reqHead]){
        NSArray* arr = [reqStr componentsSeparatedByString:reqHead];
        if (arr.count <= 0) {
            return YES;
        }
        NSString* paraStr = arr.lastObject;
        
        //获取参数名
        NSRange range = [paraStr rangeOfString:@"/"];
        NSString* optName;
        if (range.location == NSNotFound) {
            optName = paraStr;
            paraStr = @"";
        } else {
            range.length = range.location;
            range.location = 0;
            optName = [paraStr substringWithRange:range];
            paraStr = [paraStr substringFromIndex:range.length];
        }
        
        //获取参数值，去除开始部分的"/"
        unichar charBuffer[paraStr.length];
        [paraStr getCharacters:charBuffer];
        NSInteger p = 0;
        while (p < paraStr.length && charBuffer[p] == '/') {
            p++;
        }
        paraStr = [paraStr substringFromIndex:p];
        return [self requestByJS:optName paraValue:paraStr];
    }
    return YES;
}

- (BOOL)requestByJS:(NSString *)request paraValue:(NSString *)value {
    if ([request isEqualToString:@"show_image"]
        || [request isEqualToString:@"show_gif"]
        ) {
        
        for (int i = 0; i < _urlArray.count; i++) {
            if ([_urlArray[i] isEqualToString:value]) {
                _photoIndex = i;
                [self browerPhoto];
                break;
            }
        }
        return NO;
    }
    return YES;
}


#pragma mark - getter
- (UIWebView*)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
}


@end

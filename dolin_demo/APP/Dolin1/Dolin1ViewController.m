//
//  Dolin1ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin1ViewController.h"
#import "YYFPSLabel.h"
#import "DLAnimateTransition.h"
#import "DLPhotoAlbumPickerVC.h"
#import <objc/runtime.h>
#import "DLSystemPermissionsManager.h"
#import "MJRefresh.h"

@interface Dolin1ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation Dolin1ViewController

#pragma mark -  life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self setUpFPSLabel];
    [self setRightBarBtn];
    
    self.arr = [@[
                  @"动画相关-Animation_Study_VC",
                  @"照片选取器-DLPhotoAlbumPickerVC",
                  @"仿keep引导页-SimulateKeepViewController",
                  @"仿掌盟个人中心-ImitateTGPPersonCenterVC",
                  @"仿Twitter-SimulateTwitterViewController",
                  @"仿淘宝商品详情-ImitateGoodDetailVC",
                  @"链式编程-ChainCodeVC",
                  @"禁用旋转时全屏横屏方法-ChangeDeviceOrientVC",
                  @"runtime-RunTimeStudy_VC",
                  @"AutoLayoutPriority-AutoLayoutPriority",
                  @"lottie（牛B）-LottieStudyVC",
                  @"UITableViewFDTemplateLayoutCell-FDTemplateVC",
                  @"extensionStudy-AddNoteViewController",
                  @"DLVideoVC-DLVideoVC",
                  @"最近较火的Banner-Banner2VC",
                  @"联动table-LinkworkTableViewVC",
                  @"AutoLayout+Scroll-AutoLayout_ScrollViewVC",
                  GET_STR(Banner-BannerViewController),
                  @"通讯录相关-GetContactsVC",
                  @"苹果密码框bug-PwdTextFieldBugViewController",
                  @"UIScrollView奇技淫巧-StrangeScorllViewController",
                  @"自定义Label-DolinLabelViewController",
                  @"鬼相册-GhostAlbumViewController",
                  @"贝塞尔先生-UIBezierPathViewController",
                  @"贝塞尔先生-UIBezierPathVC",
                  @"富文本-RichTextViewController",
                  @"TestWebView-TestWebViewVC",
                  @"TestWKWebViewVC-TestWKWebViewVC",
                  @"FmdbVC-FmdbVC"
                  ]mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    // 再次回到这个页面cell选中效果慢慢消失
    if (selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
#pragma mark -  method

/**
 window上添加FPSLabel
 */
- (void)setUpFPSLabel {
    YYFPSLabel *fps = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - 20, 100, 20)];
    [[UIApplication sharedApplication].keyWindow addSubview:fps];
}

/**
 给cell添加动画效果
 
 @param cell
 */
- (void)animateCell:(UITableViewCell*)cell {
    cell.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:1 delay:0.6 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        cell.transform = CGAffineTransformIdentity;
    } completion:nil];
}


- (void)setRightBarBtn {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // 这个addData由JSPatch实现
    // 消除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [btn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//- (void)addData {
//   
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"FirstTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}

#pragma mark -  UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = _arr[indexPath.row];
    NSString *className = [[title componentsSeparatedByString:@"-"] lastObject];
    
    if ([className isEqualToString:@"DLPhotoAlbumPickerVC"]) {
        if(![DLSystemPermissionsManager requestAuthorization:SystemPermissionsPhotoLibrary withSureBtnClickBlock:nil]) {
            return;
        }
    }
    
    UIViewController* viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = [[title componentsSeparatedByString:@"-"] firstObject];
    viewController.hidesBottomBarWhenPushed = YES;
    
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:viewController animated:YES];
}

// 闭合cell分割线需要实现此协议
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // [self animateCell:cell];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 仅在Dolin1VC做动画
    if (operation == UINavigationControllerOperationPush && [fromVC isKindOfClass:[self class]]) {
        return [DLAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypePush];
    }
    return nil;
}


#pragma mark -  getter
- (UITableView*)tableView {
    if (!_tableView) {
        CGRect rect = rect = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end

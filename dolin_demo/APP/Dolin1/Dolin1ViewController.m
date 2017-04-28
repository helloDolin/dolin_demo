//
//  Dolin1ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin1ViewController.h"
#import "YYFPSLabel.h"
#import "LinAnimateTransition.h"

@interface Dolin1ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation Dolin1ViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.view addSubview:self.tableView];
    
//    [self setUpFPSLabel];
//    [self setUpRefreshControl];
    [self setLeftBarBtn];
    [self setRightBarBtn];

    self.arr = [@[
                  @"Interview-InterviewVC",
                  @"动画相关-Animation_Study_VC",
                  @"最近较火的Banner-Banner2VC",
                  @"仿keep引导页-SimulateKeepViewController",
                  @"仿Twitter-SimulateTwitterViewController",
                  @"仿淘宝商品详情-ImitateGoodDetailVC",
                  @"联动table-LinkworkTableViewVC",
                  @"链式编程-ChainCodeVC",
                  @"AutoLayout+Scroll-AutoLayout_ScrollViewVC",
                  GET_STR(Banner-BannerViewController),
                  @"通讯录相关-GetContactsVC",
                  @"苹果密码框bug-PwdTextFieldBugViewController",
                  @"UIScrollView奇技淫巧-StrangeScorllViewController",
                  @"自定义Label-DolinLabelViewController",
                  @"鬼相册-GhostAlbumViewController",
                  @"禁用旋转时全屏横屏方法-ChangeDeviceOrientVC",
                  @"贝塞尔先生-UIBezierPathViewController",
                  @"贝塞尔先生-UIBezierPathVC",
                  @"富文本-RichTextViewController",
                  @"runtime-RunTimeStudy_VC",
                  @"TestWebView-TestWebViewVC",
                  @"TestWKWebViewVC-TestWKWebViewVC",
                  ]mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 再次回到这个页面cell选中效果慢慢消失
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
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
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.frame = CGRectMake(0, 64, SCREEN_WIDTH, 20);
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

// 可惜这种方式只能下拉刷新，不能上拉加载
- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新啊"];
    [self.refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    //    CGRect bounds = self.refreshControl.bounds;
    //    bounds.origin.x = 50; // 左移50 -50就是右移
    //    bounds.origin.y = 10; // 上移10
    //    self.refreshControl.bounds = bounds;
    self.tableView.refreshControl = self.refreshControl;
}

// <##>
- (void)setLeftBarBtn {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"crash", nil) style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)setRightBarBtn {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // 这个addData由JSPatch实现
    //<#消除警告#>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [btn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -  event
- (void)refreshAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

//- (void)addData {
//   
//}

- (void)leftItemAction {
    exit(0);  // 关闭程序，审核不会给过
    return;
    static BOOL b = YES;
    if (b) {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"取消";
    } else {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
    b = !b;
}


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
    
    UIViewController* viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = [[title componentsSeparatedByString:@"-"] firstObject];
    viewController.hidesBottomBarWhenPushed = YES;
    
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

// 闭合cell分割线需要实现此协议
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self animateCell:cell];
    
    
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

// 编辑状态下的代理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 仅在Dolin1VC做动画
    if (operation == UINavigationControllerOperationPush && [fromVC isKindOfClass:[self class]]) {
        return [LinAnimateTransition linAnimateTransitionWithType:LinAnimateTransitionTypePush];
    }
    return nil;
}


#pragma mark -  getter
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.allowsSelectionDuringEditing = YES; 编辑状态下也可以点
    }
    return _tableView;
}
@end

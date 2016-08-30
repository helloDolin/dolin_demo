//
//  Dolin1ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin1ViewController.h"

@interface Dolin1ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* _arr;
}

@property (nonatomic,strong)UITableView* tableView;

@end

@implementation Dolin1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    [self setLeftBarBtn];
    
    _arr = @[
             GET_STR(Banner-BannerViewController),
             @"仿Twitter-SimulateTwitterViewController",
             @"富文本-RichTextViewController",
             @"苹果密码框bug-PwdTextFieldBugViewController",
             @"AnimationImages-AnimationImagesViewController",
             @"点赞动画-AnimationLikeBtnViewController",
             @"点击cell玩玩-SpreadOrShrinkSectionViewController",
             @"仿keep引导页-SimulateKeepViewController",
             @"本地推送-LocalNotificationViewController",
             @"UIScrollView奇技淫巧-StrangeScorllViewController",
             @"自定义Label-DolinLabelViewController",
             @"鬼相册-GhostAlbumViewController",
             @"动画+Masonry学习-AnimationStudyVC",
             @"禁用旋转时全屏横屏方法-ChangeDeviceOrientVC"
             ];
}

- (void)setLeftBarBtn {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)leftItemAction {
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 再次回到这个页面cell选中效果慢慢消失
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
    }
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}

#pragma mark -  UITableViewDelegate 
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

#pragma mark -  getter
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:FULL_SCREEN_FRAME style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.allowsSelectionDuringEditing = YES; 编辑状态下也可以点击
    }
    return _tableView;
}
@end

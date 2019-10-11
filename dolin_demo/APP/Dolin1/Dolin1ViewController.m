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
#import "DLFoldCellModel.h"
#import "AppDelegate.h"

@interface Dolin1ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray<DLFoldCellModel*> *data;

@end

@implementation Dolin1ViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    // 再次回到这个页面cell选中效果慢慢消失
    if (selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    }
}

#pragma mark -  method
- (void)setupUI {
    [self.view addSubview:self.tableView];
    // [self setupFPSLabel];
    // [self setRightBarBtn];
    [self setLeftBarBtn];
    [self setupTableViewData];
    self.navigationController.delegate = self;
}

/**
 设置 tableview 的数据
 */
- (void)setupTableViewData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dolin1data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.data = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DLFoldCellModel* model = [DLFoldCellModel modelWithDic:obj];
        [self.data addObject:model];
    }];
}

/**
 window上添加FPSLabel
 */
- (void)setupFPSLabel {
    YYFPSLabel *fps = [[YYFPSLabel alloc]initWithFrame:CGRectMake(80, NAVIGATION_BAR_HEIGHT - 20, 100, 20)];
    [[UIApplication sharedApplication].keyWindow addSubview:fps];
}

- (void)jump2FlutterPage {
//    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
//    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
////    [self.navigationController pushViewController:flutterViewController animated:YES];
//    flutterViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:flutterViewController animated:false completion:nil];
}

- (void)setLeftBarBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Flutter" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(jump2FlutterPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
}

/**
 JSPatch test（addData由JSPatch实现）
 */
- (void)setRightBarBtn {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // 消除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [btn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)jumpToPageByModel:(DLFoldCellModel*)model {
    NSString *title = model.text;
    NSString *className = [[title componentsSeparatedByString:@"-"] lastObject];
    // 如果是相册，先进行权限判断
    if ([className isEqualToString:@"DLPhotoAlbumPickerVC"]) {
        if(![DLSystemPermissionsManager requestAuthorization:SystemPermissionsPhotoLibrary withSureBtnClickBlock:nil]) {
            return;
        }
    }
    // 单多选 present
    if ([className isEqualToString:@"Radio_MultipleChoiceVC"]) {
        UIViewController* vc = [[NSClassFromString(className) alloc] init];
        vc.title = [[title componentsSeparatedByString:@"-"] firstObject];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    UIViewController* vc = [[NSClassFromString(className) alloc] init];
    vc.title = [[title componentsSeparatedByString:@"-"] firstObject];
    vc.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"reuseIdetify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.indentationWidth = 40;// 设置缩进宽度
    }
    DLFoldCellModel* model = self.data[indexPath.row];
    cell.textLabel.text = model.text;
    return cell;
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLFoldCellModel *model = self.data[indexPath.row];
    return model.level.intValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLFoldCellModel* didSelectModel = self.data[indexPath.row];
    [tableView beginUpdates];
    if (didSelectModel.belowCount == 0) {
        NSArray* subModels = [didSelectModel open];
        // 不能再被展开，进行跳转
        if (!subModels || subModels.count == 0) {
            [self jumpToPageByModel:didSelectModel];
        }
        
        NSIndexSet* indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1,subModels.count})];
        [self.data insertObjects:subModels atIndexes:indexes];
        
        NSMutableArray* indexPaths = [NSMutableArray array];
        [subModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath* insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 + idx inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }];
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
    else {
        NSArray* subModels = [self.data subarrayWithRange:((NSRange){indexPath.row + 1,didSelectModel.belowCount})];
        [didSelectModel closeWithSubModels:subModels];
        [self.data removeObjectsInArray:subModels];
        
        NSMutableArray* indexPaths = [NSMutableArray array];
        [subModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath* insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + idx) inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
    [tableView endUpdates];
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

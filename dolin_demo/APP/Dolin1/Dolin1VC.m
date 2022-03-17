//
//  Dolin1VC.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin1VC.h"

#import "DLPhotoAlbumPickerVC.h"

#import "DLSystemPermissionsManager.h"

#import "DLFoldCellModel.h"

#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>

#import "DLAnimateTransition.h"

@interface Dolin1VC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray<DLFoldCellModel*> *data;

@end

@implementation Dolin1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViewData];
    [self setupUI];
}

#pragma mark -  method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
}

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
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end

//
//  LinkworkTableViewVC.m
//  dolin_demo
//
//  Created by dolin on 2017/3/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LinkworkTableViewVC.h"
#import "LinkworkLeftCell.h"

@interface LinkworkTableViewVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_arr;
}

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSIndexPath *currentSelectIndexPath; // 保存左边选中的indexpath

@end

@implementation LinkworkTableViewVC

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _arr = @[
             @{@"title":@"热销榜",@"data":@[@"热销榜1",@"热销榜2"]},
             @{@"title":@"优惠",@"data":@[@"优惠1",@"优惠2",@"优惠3",@"优惠4",@"优惠5"]},
             @{@"title":@"特色",@"data":@[@"特色1"]},
             @{@"title":@"锅类",@"data":@[@"锅类1",@"锅类2",@"锅类3"]},
             @{@"title":@"零食",@"data":@[@"零食1",@"零食2",@"零食3"]},
             @{@"title":@"汤",@"data":@[@"汤1",@"汤2",@"汤3"]},
             @{@"title":@"面",@"data":@[@"面1",@"面2",@"面3"]},
             @{@"title":@"饭",@"data":@[@"炒饭",@"拌饭",@"石锅饭"]},
             @{@"title":@"饮品",@"data":@[@"可乐",@"雪碧",@"脉动",@"脉动",@"脉动",@"脉动",@"脉动",@"脉动"]}
             ];
    
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    // 默认选择左边tableView的第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method
- (void)selectLeftTableViewWithScrollView:(UIScrollView *)scrollView {
    if (self.currentSelectIndexPath) {
        return;
    }
    // 如果现在滑动的是左边的tableView，不做任何处理
    if (scrollView == self.leftTableView) {
        return;
    }
    // 滚动右边tableView，设置选中左边的tableView某一行。
    // indexPathsForVisibleRows属性返回屏幕上可见的cell的indexPath数组，利用这个属性就可以找到目前所在的分区
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.rightTableView.indexPathsForVisibleRows.firstObject.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
#pragma mark - event

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }
    return _arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return _arr.count;
    }
    NSArray *data = _arr[section][@"data"];
    return data.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return nil;
    }
    return _arr[section][@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // left
    LinkworkLeftCell *linkworkLeftCell = [LinkworkLeftCell cellWithTableView:tableView];
    if (tableView == self.leftTableView) {
        linkworkLeftCell.titleLbl.text = _arr[indexPath.row][@"title"];
        return linkworkLeftCell;
    }
    
    // right
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _arr[indexPath.section][@"data"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果点击的是右边的tableView暂不做任何处理
    if (tableView == self.rightTableView) {
        return;
    }
    
    if (tableView == self.leftTableView && indexPath != self.currentSelectIndexPath) {
        [tableView deselectRowAtIndexPath:self.currentSelectIndexPath animated:YES];
    }
    
    // 点击左边的tableView，设置选中右边的tableView某一行。左边的tableView的每一行对应右边tableView的每个分区
    [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.currentSelectIndexPath = indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) return 0;
    return 30;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 重新选中一下当前选中的行数，不然会有bug
    if (self.currentSelectIndexPath) {
        self.currentSelectIndexPath = nil;
    }
}

#pragma mark - getter && setter
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:(CGRect){0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH * 0.25f, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT}];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:(CGRect){SCREEN_WIDTH * 0.25f, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH * 0.75f, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT}];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}

#pragma mark - API

#pragma mark - override

@end

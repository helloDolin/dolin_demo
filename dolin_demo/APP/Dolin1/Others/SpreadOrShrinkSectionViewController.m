//
//  SpreadOrShrinkSectionViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/15.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SpreadOrShrinkSectionViewController.h"

static const CGFloat kCellHeight = 40.0;

@interface SpreadOrShrinkSectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _sectionArr;
    NSMutableArray* _selectedSectionArr; // 记录sceion是否被展开
    NSMutableArray* _rowsInSection;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SpreadOrShrinkSectionViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ps:_sectionArr与_selectedSectionArr与_rowsInSection的count要相同
    // 这里的设计不好
    _sectionArr = [@[@"section1",@"section2",@"section3",@"section4"]mutableCopy];
    _selectedSectionArr = [@[@"1",@"0",@"0",@"0"]mutableCopy];
    _rowsInSection = [@[@"2",@"3",@"4",@"6"]mutableCopy];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  按钮事件
- (void)buttonAction:(UIButton*)button {
    if ([_selectedSectionArr[button.tag - 1000] isEqualToString:@"0"]) {
        [_selectedSectionArr replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [_selectedSectionArr replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_selectedSectionArr[section] isEqualToString:@"1"]) {
        return [_rowsInSection[section]integerValue];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _sectionArr[indexPath.section];
    return cell;
}

#pragma mark -  UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, kCellHeight);
    [sectionButton setTitle:_sectionArr[section] forState:UIControlStateNormal];
    [sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    sectionButton.tag = 1000 + section;
    sectionButton.backgroundColor = [UIColor orangeColor];
//    [sectionButton setImage:[UIImage imageNamed:@"twitter_bg"] forState:UIControlStateNormal];
    
    return sectionButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeight;
}

#pragma mark -  getter
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kCellHeight;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end

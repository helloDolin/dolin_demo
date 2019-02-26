//
//  WebIsTableHeaderViewController.m
//  dolin_demo
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "StrangeScorllViewController.h"
#import "StrangeTableViewCell.h"

/*
 *  tableView与scrollView的frame和inset都应该一样
 *  scrollView的contentSize的宽刚好比tableView的contentSize的宽大1（让其可以横滑）
 *  将scrollView的交互关闭，把scrollView的手势添加到tableView上（为了cell可以点击）
 */

@interface StrangeScorllViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation StrangeScorllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StrangeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StrangeTableViewCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.scrollView.contentSize = CGSizeMake(self.tableView.frame.size.width + 1, self.tableView.contentSize.height);
}

/**
 *  把scollView的y给tableView的y（让tableView也可以滚动）
 *  滑动的时候改变cell元素的约束
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    for (StrangeTableViewCell* cell in self.tableView.visibleCells) {
        cell.rightConstraint.constant = scrollView.contentOffset.x - 45;
    }
}

#pragma mark - getter
- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
        _scrollView.userInteractionEnabled = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 65;
        [_tableView registerNib:[UINib nibWithNibName:@"StrangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"StrangeTableViewCell"];
        [_tableView addGestureRecognizer:self.scrollView.panGestureRecognizer];
    }
    return _tableView;
}


@end

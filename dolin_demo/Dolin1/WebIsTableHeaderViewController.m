//
//  WebIsTableHeaderViewController.m
//  dolin_demo
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "WebIsTableHeaderViewController.h"

@interface WebIsTableHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *tableHeaderView;

@end

@implementation WebIsTableHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row]];
    return cell;
}


#pragma mark - getter
- (UIWebView*)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        [_tableHeaderView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app2.xozaa.com/index.php?m=Home&c=Web&a=newsDetail&id=3022"]]];
        
        // 禁止响应事件、禁止交互
        _tableHeaderView.userInteractionEnabled = NO;
        
        // 取消回弹效果
        _tableHeaderView.scrollView.bounces = NO;
    }
    return _tableHeaderView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.bounces = NO;
        
        // 给web添加事件
        [_tableView addGestureRecognizer:self.tableHeaderView.scrollView.panGestureRecognizer];
    }
    return _tableView;
}


@end

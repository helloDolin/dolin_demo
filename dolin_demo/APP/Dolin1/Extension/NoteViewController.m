//
//  NoteViewController.m
//  dolin_demo
//
//  Created by dolin on 2017/5/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteListDelegate.h"

@interface NoteViewController ()
{
    NoteListDelegate *_tableDelegate;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 44.0;
        _tableDelegate = [[NoteListDelegate alloc] init];
        _tableDelegate.vc = self;
        _tableView.delegate = _tableDelegate;
        _tableView.dataSource = _tableDelegate;
    }
    return _tableView;
}
@end

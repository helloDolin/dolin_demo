//
//  SimulateTwitterViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SimulateTwitterViewController.h"
#import "SimulateTwitterView.h"

@interface SimulateTwitterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SimulateTwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SimulateTwitterView *simulateTwitterView = [[SimulateTwitterView alloc]initTableViewWithBackgound:[UIImage imageNamed:@"twitter_bg"] avatarImage:[UIImage imageNamed:@"launch_img"] titleString:@"dolin" subtitleString:@"\(^o^)/~👌"];
    
    simulateTwitterView.tableView.delegate = self;
    simulateTwitterView.tableView.dataSource = self;
    [self.view addSubview:simulateTwitterView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}



@end

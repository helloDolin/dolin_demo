//
//  ImitateTGPPersonCenterVC.m
//  dolin_demo
//
//  Created by dolin on 2017/6/2.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "ImitateTGPPersonCenterVC.h"
#import "UINavigationBar+Awesome.h"

static float const kHeaderViewHeight = 246.0;
static float const kTitlesViewHeight = 46.0;
static float const kTitlesViewY = 200.0;


@interface ImitateTGPPersonCenterVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    // headerView悬停时的y值
    CGFloat _headerScrollHoverY;
}

// 整体UI布局
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;

// headerView相关
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation ImitateTGPPersonCenterVC
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - method
- (void)layoutUI {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.scrollView addSubview:self.tableView3];
    [self layoutHeaderView];
}

- (void)createTableHeadView:(UITableView *)tableView {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - event
- (void)titleClick:(UIButton*)button {
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat indicatorViewWidth = button.titleLabel.frame.size.width;
        CGFloat indicatorViewCenterX = button.center.x;
        
        self.indicatorView.frame = CGRectMake(indicatorViewCenterX - indicatorViewWidth / 2, kTitlesViewHeight - 1, indicatorViewWidth, 1);
    }];
    
    // 滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)layoutHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    self.headerView.backgroundColor = RANDOM_UICOLOR;
    [self.view addSubview:self.headerView];
    
    self.titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, kTitlesViewY, SCREEN_WIDTH, kTitlesViewHeight)];
    self.titlesView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headerView addSubview:self.titlesView];
    
    // 红色指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    
    // 内部的子标签
    NSArray *titles = @[@"战绩", @"能力" ,@"我的资产"];
    CGFloat width = SCREEN_WIDTH / titles.count;
    CGFloat height = kTitlesViewHeight;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        button.frame = CGRectMake(i * width, 0, width, height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            CGFloat indicatorViewWidth = button.titleLabel.frame.size.width;
            CGFloat indicatorViewCenterX = button.center.x;
            
            self.indicatorView.frame = CGRectMake(indicatorViewCenterX - indicatorViewWidth / 2, kTitlesViewHeight - 1, indicatorViewWidth, 1);
            
        }
    }
    [self.titlesView addSubview:self.indicatorView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    _headerScrollHoverY = (kHeaderViewHeight - kTitlesViewHeight - 64);
    if (offsetY > _headerScrollHoverY) {
        self.headerView.y = -_headerScrollHoverY;
        return;
    }
    
    // 其余滑动
    self.headerView.y = -offsetY;
    
    // 解决结束刷新时候，其他tableView同步偏移
    if (offsetY == 0) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self titleClick:self.titlesView.subviews[index]];
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_scrollView]) {
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

// 设置tableView的偏移量
- (void)setTableViewContentOffsetWithTag:(NSInteger)tag contentOffset:(CGFloat)offset {
    
    CGFloat tableViewOffset = offset;
    
    if(offset > _headerScrollHoverY) {
        tableViewOffset = _headerScrollHoverY;
    }
    
    if (tag == 101) {
        [self.tableView2 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [self.tableView3 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
    else if(tag == 102) {
        [self.tableView1 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [self.tableView3 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
    else {
        [self.tableView1 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [self.tableView2 setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    
    return cell;
}


#pragma mark -  getter
- (UITableView*)tableView1 {
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView1.tag = 101;
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        _tableView1.backgroundColor = RANDOM_UICOLOR;
        [self createTableHeadView:_tableView1];
    }
    return _tableView1;
}

- (UITableView*)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(1  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView2.tag = 102;
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView2.backgroundColor = RANDOM_UICOLOR;
        [self createTableHeadView:_tableView2];
    }
    return _tableView2;
}

- (UITableView*)tableView3 {
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(2  * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView3.tag = 103;
        _tableView3.dataSource = self;
        _tableView3.delegate = self;
        _tableView3.backgroundColor = RANDOM_UICOLOR;
        [self createTableHeadView:_tableView3];
    }
    return _tableView3;
}

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollView;
}

@end

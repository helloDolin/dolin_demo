//
//  Dolin2VC.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "Dolin2VC.h"
#import "AFHTTPSessionManager.h"
#import "RecommendModel.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "RecommendMusicCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "DLModel.h"

@interface Dolin2VC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray<DLResultTracksModel*>* _data;
    int _pageNum;
}
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation Dolin2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    _pageNum = 1;
    _data = [NSMutableArray array];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupEmptyView {
    self.tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"MT"
                                                                  titleStr:@"无数据"
                                                                 detailStr:@"请稍后再试!"
                                                               btnTitleStr:@"重新加载"
                                                                    target:self
                                                                    action:@selector(req)];
}

#pragma mark -  method
- (void)req {
    // 网易API
    NSString* urlStr = [NSString stringWithFormat:@"http://music.163.com/api/playlist/detail?id=107875443"];
    
    // 猫弄API
//    NSString* urlStr = [NSString stringWithFormat:@"http://mmmono.com/api/v3/tab/?start=%d%%2C10&tab_id=8&tab_type=3",_pageNum];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    @weakify(self);
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        DLModel* model = [DLModel yy_modelWithJSON:responseObject];
        self->_data = [model.result.tracks mutableCopy];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.navigationItem.title = model.result.creator.nickname;
        if (!self ->_data.count) {
            [self setupEmptyView];
        }
        
//        if (self->_data.count == 0) {
//            [self.tableView.mj_header endRefreshing];
//        }
//        else {
//            [self.tableView.mj_footer endRefreshing];
//        }
//        NSArray* arr = responseObject[@"entity_list"];
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            RecommendModel* recommendModel = [RecommendModel yy_modelWithJSON:obj[@"meow"]];
//            [self->_data addObject:recommendModel];
//        }];
//        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self setupEmptyView];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendMusicCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecommendMusicCell class])];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark -  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
//    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([RecommendMusicCell class]) configuration:^(RecommendMusicCell* cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
    DLResultTracksModel* model = _data[indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([RecommendMusicCell class]) cacheByKey:model.tracksModelId configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    return height;
}

- (void)configureCell:(RecommendMusicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.recommendModel = _data[indexPath.row];
    cell.dLResultTracksModel = _data[indexPath.row];
}

#pragma mark - getter
- (UITableView*)tableView {
    if (!_tableView) {
        CGRect rect = rect = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT);
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // 解决reloadTableView之后滚动条乱跳的问题
        // iOS 11Self-Sizing自动打开后，contentSize和contentOffset都可能发生改变
        // 通过以下方式禁用
#ifdef __IPHONE_11_0
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
#endif
        [_tableView registerClass:[RecommendMusicCell class] forCellReuseIdentifier:NSStringFromClass([RecommendMusicCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self->_data removeAllObjects];
            self->_pageNum = 1;
            [self req];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->_pageNum++;
            [self req];
        }];
    }
    return _tableView;
}
@end

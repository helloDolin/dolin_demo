//
//  FDTemplateVC.m
//  dolin_demo
//
//  Created by Dolin on 2019/2/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "FDTemplateVC.h"
#import "FDTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface FDTemplateVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* _arr;
}

@property(nonatomic,strong)UITableView* tableView;

@end

@implementation FDTemplateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.fd_debugLogEnabled = YES;
    
    FDCellModel* model1 = [[FDCellModel alloc]init];
    model1.userIconUrl = @"https://upload.jianshu.io/users/upload_avatars/2998364/9f8351c3734b.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240";
    model1.userName = @"dolin1";
    model1.shuoshuo = @"1";
    
    FDCellModel* model2 = [[FDCellModel alloc]init];
    model2.userIconUrl = @"https://upload.jianshu.io/users/upload_avatars/2587459/0c7e061f-e78e-4b09-b511-340846c4ea0f.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240";
    model2.userName = @"dolin2";
    model2.shuoshuo = @"22";
    model2.urls = @[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2004649980,2079869552&fm=26&gp=0.jpg"];
    
    FDCellModel* model3 = [[FDCellModel alloc]init];
    model3.userIconUrl = @"https://upload.jianshu.io/users/upload_avatars/9234143/0819f188-bedf-4878-bbc7-bf08c163314e?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240";
    model3.userName = @"dolin3";
    model3.shuoshuo = @"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333";
    model3.urls = @[@"http://p1.music.126.net/NswM-qqvBKQ6TFAtCqm00g==/109951162960586703.jpg",
                    @"http://p1.music.126.net/SsolG1eEIZIj_rUmMKNrZQ==/2946691217284932.jpg",
                    @"http://p1.music.126.net/QBQvSe84znaWIm2PrhQ_ng==/5930765720512200.jpg",
                    @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3043554241,523381466&fm=26&gp=0.jpg",
                    ];
    
    FDCellModel* model4 = [[FDCellModel alloc]init];
    model4.userIconUrl = @"https://upload.jianshu.io/users/upload_avatars/9234143/0819f188-bedf-4878-bbc7-bf08c163314e?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240";
    model4.userName = @"dolin";
    model4.shuoshuo = @"hahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahaha";
    model4.urls = @[@"http://p1.music.126.net/NswM-qqvBKQ6TFAtCqm00g==/109951162960586703.jpg",
                    @"http://p1.music.126.net/NswM-qqvBKQ6TFAtCqm00g==/109951162960586703.jpg",
                    @"http://p1.music.126.net/SsolG1eEIZIj_rUmMKNrZQ==/2946691217284932.jpg",
                    @"http://p1.music.126.net/QBQvSe84znaWIm2PrhQ_ng==/5930765720512200.jpg",
                    @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3043554241,523381466&fm=26&gp=0.jpg",
                    @"http://p1.music.126.net/NswM-qqvBKQ6TFAtCqm00g==/109951162960586703.jpg",
                    @"http://p1.music.126.net/SsolG1eEIZIj_rUmMKNrZQ==/2946691217284932.jpg",
                    @"http://p1.music.126.net/QBQvSe84znaWIm2PrhQ_ng==/5930765720512200.jpg",
                    @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3043554241,523381466&fm=26&gp=0.jpg"];
    
    _arr = @[model1,model2,model3,model4,model4,model3,model2,model1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDTableViewCell* cell = [FDTableViewCell cellWithTableView:tableView];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"FDTableViewCell" configuration:^(FDTableViewCell* cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    return height;
}

- (void)configureCell:(FDTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = _arr[indexPath.row];
}

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end

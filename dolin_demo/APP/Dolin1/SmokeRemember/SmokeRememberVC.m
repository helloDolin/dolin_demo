//
//  SmokeRememberVC.m
//  dolin_demo
//
//  Created by dolin on 2017/4/26.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "SmokeRememberVC.h"
#import "SmokeRememberCell.h"
#import <CoreData/CoreData.h>
#import "NSDate+Utilities.h"
#import "Smoke+CoreDataClass.h"


@interface SmokeRememberVC ()<UITableViewDataSource>
{
    UILabel* _sumLbl;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSMutableArray<Smoke*> *data;
@property (nonatomic, strong) UIView *tableHeaderView;
@end

@implementation SmokeRememberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self setLeftBarBtn];
    
    self.context = [self createDbContext];
    [self select];
}

/**
 创建对象管理上下文ManagedObjectContext可以细分为：
 
 加载模型文件
 指定数据存储路径
 创建对应数据类型的存储
 创建管理对象上下方并指定存储
 
 @return
 */
- (NSManagedObjectContext *)createDbContext{
    // 打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 创建数据解析器
    NSPersistentStoreCoordinator *storeCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 创建数据库保存路径
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *path = [dir stringByAppendingPathComponent:@"smoke.db"];
    NSURL *url = [NSURL fileURLWithPath:path];
    // 添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:url
                                         options:nil
                                           error:&error];
    
    NSManagedObjectContext *context = nil;
    if( !error ){
        // 创建对象管理上下文，并设置数据解析器
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = storeCoordinator;
        NSLog(@"数据库打开成功！");
    }
    else{
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }
    return context;
}


// setLeftBarBtnItem
- (void)setLeftBarBtn {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)rightItemAction {
    NSDate* currentDate = [NSDate date];
    Smoke *smoke = [NSEntityDescription insertNewObjectForEntityForName:@"Smoke"
                                                     inManagedObjectContext:self.context];
    smoke.date = currentDate;
    smoke.count = 1;
    NSError *error;
    // 保存上下文,这里需要注意，增、删、改操作完最后必须调用管理对象上下文的保存方法，否则操作不会执行。
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
    
    [self select];
}

- (void)select {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Smoke" inManagedObjectContext:self.context];
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    [req setEntity:entity];
    
    NSArray<Smoke*>*arr = [self.context executeFetchRequest:req error:nil];
    _sumLbl.text = [NSString stringWithFormat:@"总：%lu",(unsigned long)arr.count];
    self.data = [arr mutableCopy];
    self.data = (NSMutableArray*)[[self.data reverseObjectEnumerator] allObjects];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SmokeRememberCell* cell = [SmokeRememberCell cellWithTableView:tableView];
    Smoke* smoke = self.data[indexPath.row];
    cell.dateLbl.text = [smoke.date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.countLbl.text = [NSString stringWithFormat:@"%lld根",smoke.count];
    return cell;
}

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (UIView*)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5)];
        _tableHeaderView.backgroundColor = RANDOM_UICOLOR;
        
        _sumLbl = [[UILabel alloc]init];
        _sumLbl.font = [UIFont systemFontOfSize:20];
        _sumLbl.textColor = [UIColor whiteColor];
        _sumLbl.textAlignment = NSTextAlignmentCenter;
        
        [_tableHeaderView addSubview:_sumLbl];
        
        [_sumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return _tableHeaderView;
}

@end

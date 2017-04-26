//
//  CoreDataVC.m
//  dolin_demo
//
//  Created by dolin on 2017/4/26.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "CoreDataVC.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"
#import "Classes+CoreDataClass.h"

@interface CoreDataVC ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation CoreDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.context = [self createDbContext];
    
    // testBtn
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 64, 375, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"hello" forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction {
    static int num = 0;
    num++;
    if (num == 1) {
        [self addClassTest];
    }
    else if (num == 2) {
        [self selectClasses];
    }
    else if (num == 3) {
        
    }
    else if (num == 4) {
        
    }
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
    NSString *path = [dir stringByAppendingPathComponent:@"myDatabase.db"];
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

- (void)selectClasses {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Classes" inManagedObjectContext:self.context];
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    // 建立某一类的请求
    [req setEntity:entity];
    
    NSArray<Classes*>*arr = [self.context executeFetchRequest:req error:nil];
    [arr enumerateObjectsUsingBlock:^(Classes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%lld,%@",obj.c_id,obj.c_name);
    }];
}

- (void)addClassTest {
    // 添加一个对象
    Classes *classes = [NSEntityDescription insertNewObjectForEntityForName:@"Classes"
                                                     inManagedObjectContext:self.context];
    classes.c_id = 301;
    classes.c_name = @"高三(1)班";
    NSError *error;
    // 保存上下文,这里需要注意，增、删、改操作完最后必须调用管理对象上下文的保存方法，否则操作不会执行。
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

- (void)removeClasses:(Classes*)classes {
    [self.context deleteObject:classes];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误，错误信息：%@!",error.localizedDescription);
    }
}

- (void)modifyClasses:(Classes *)classes {
    classes.c_name = @"(1)班";
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"修改过程中发生错误,错误信息：%@",error.localizedDescription);
    }
}
@end

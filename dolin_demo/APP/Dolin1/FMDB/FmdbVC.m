//
//  FmdbVC.m
//  dolin_demo
//
//  Created by Dolin on 2019/3/12.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "FmdbVC.h"
#import "FMDatabase.h"

/**
 🦍🦍🦍
 FMDatabase：一个 FMDatabase 对象就代表一个单独的SQLite数据库，用来执行SQL语句
 FMResultSet：使用 FMDatabase 执行查询后的结果集
 FMDatabaseQueue：用于在多线程中指向多个查询或更新，它是线程安全的
 */
@interface FmdbVC ()

@end

@implementation FmdbVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testFMDB];
}

- (void)testFMDB {
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];// 创建database路径（Document下）
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];// 创建对应路径下的数据库
    [db open];
    if (![db open]) {
        NSLog(@"db open fail");
        return;
    }
    
    NSString* sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL,'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
    
    // 增删改查中 除了查询（executeQuery），其余操作都用（executeUpdate）,包括创建表也是用executeUpdate
    BOOL result = [db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
    }
    // 不确定的参数用？来占位
    //    BOOL isInsertSuccess1 = [db executeUpdate:@"insert into 't_student'(name,phone,score) values(?,?,?)" withArgumentsInArray:@[@"zhangsan",@"18521568888",@88]];
    //    BOOL isInsertSuccess2 = [db executeUpdate:@"insert into 't_student'(ID,name,phone,score) values(?,?,?,?)" withArgumentsInArray:@[@2,@"lisi",@"18521566666",@6666]];
    
    NSString* selectSql = @"select * from t_student";
    FMResultSet* resultSet = [db executeQuery:selectSql];
    while ([resultSet next]) {
        int ID = [resultSet intForColumnIndex:0];
        NSString* name = [resultSet stringForColumnIndex:1];
        NSString* phone = [resultSet stringForColumnIndex:2];
        NSInteger score = [resultSet intForColumnIndex:3];
        NSLog(@"%d,%@,%@,%ld",ID,name,phone,score);
    }
}

@end

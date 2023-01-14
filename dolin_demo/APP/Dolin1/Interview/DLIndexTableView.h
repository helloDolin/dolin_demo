//
//  DLIndexTableView.h
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexedTableViewDataSource <NSObject>

- (NSArray<NSString*>*)indexTitlesForIndexTableView:(UITableView*)tableView;

@end

@interface DLIndexTableView : UITableView

@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;

@end

NS_ASSUME_NONNULL_END

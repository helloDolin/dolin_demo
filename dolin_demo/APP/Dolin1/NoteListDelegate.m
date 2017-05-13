//
//  NoteListDelegate.m
//  dolin_demo
//
//  Created by dolin on 2017/5/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "NoteListDelegate.h"
@interface NoteListDelegate()
{
    NSMutableArray *_noteList;
}
@end


@implementation NoteListDelegate

- (instancetype)init {
    if (self = [super init]) {
        _noteList = [NSMutableArray arrayWithCapacity:0];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    [_noteList removeAllObjects];
    NSArray *myNote = [[[NSUserDefaults alloc] initWithSuiteName:@"group.extension.todayWidget"] valueForKey:@"MyNote"];
    if (myNote) {
        [_noteList addObjectsFromArray:myNote];
    }
}

#pragma mark -- UITableViewDelegate && UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self loadData];
    return _noteList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noteCell"];
    }
    cell.textLabel.text = _noteList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tableView setEditing:NO animated:YES];
        NSString *note = _noteList[indexPath.row];
        NSMutableArray *myNote = [NSMutableArray arrayWithArray:[[[NSUserDefaults alloc] initWithSuiteName:@"group.extension.todayWidget"] valueForKey:@"MyNote"]];
        [myNote removeObject:note];
        [[[NSUserDefaults alloc] initWithSuiteName:@"group.extension.todayWidget"] setValue:myNote forKey:@"MyNote"];
        [_noteList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return @[delete];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.vc.extensionContext) {
        [self.vc.extensionContext openURL:[NSURL URLWithString:@"todaywidget://home"] completionHandler:nil];
    }
    
    
    
}

@end

//
//  DLUserCenter.m
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import "DLUserCenter.h"

@interface DLUserCenter()
{
    dispatch_queue_t concurrent_queue; // 并发队列
    NSMutableDictionary *userCenterDic; // 可能多个线程访问
}
@end

@implementation DLUserCenter

- (instancetype)init {
    self = [super init];
    if (self) {
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    // 由于读的操作是需要立刻返回结果，所以用 dispatch_sync
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString*)key {
    // 异步栅栏方案实现单写
    dispatch_barrier_async(concurrent_queue, ^{
        [self->userCenterDic setObject:obj forKey:key];
    });
}

@end

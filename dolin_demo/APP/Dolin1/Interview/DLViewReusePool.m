//
//  DLViewReusePool.m
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import "DLViewReusePool.h"

@interface DLViewReusePool()

@property (nonatomic, strong) NSMutableSet *waitUsedQueue;

@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation DLViewReusePool

- (instancetype)init {
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView*)dequeueReuseableView {
    UIView *view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    }
    else {
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView*)view {
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUsedQueue addObject:view];
    }
}

@end

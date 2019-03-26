//
//  Runtime_Test.m
//  dolin_demo
//
//  Created by dolin on 16/10/20.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Runtime_Test.h"
#import <objc/runtime.h>

@implementation Runtime_Test
// void(*)()
// 默认方法都有两个隐式参数

void eat(id self,SEL sel) {
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(eat)) {
        // (返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        // BOOL isAddSuccess = class_addMethod([self class], @selector(eat), eat, "v@:");
        // 这里为了走消息转发流程，暂时射为false
        // isAddSuccess = NO;
        NSLog(@"resolveInstanceMethod");
        return NO;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(eat)) {
        NSLog(@"forwardingTargetForSelector");
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(eat)) {
        NSLog(@"methodSignatureForSelector:");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation:");
}

@end

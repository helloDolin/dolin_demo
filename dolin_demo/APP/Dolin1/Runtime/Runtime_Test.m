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
// 默认方法都有两个隐式参数，
void eat(id self,SEL sel) {
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //<#消除警告#>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(eat)) {
#pragma clang diagnostic pop
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        //<#消除警告#>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        class_addMethod(self, @selector(eat), eat, "v@:");
#pragma clang diagnostic pop
    }
    return [super resolveInstanceMethod:sel];
}

@end

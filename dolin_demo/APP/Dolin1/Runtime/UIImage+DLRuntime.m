//
//  UIImage+DLRuntime.m
//  dolin_demo
//
//  Created by dolin on 16/10/20.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "UIImage+DLRuntime.h"
//#import <objc/message.h>
#import <objc/runtime.h>


@implementation UIImage (DLRuntime)

//这个问题可以引用念茜大神的一句话：使用 Method Swizzling 编程就好比切菜时使用锋利的刀，一些人因为担心切到自己所以害怕锋利的刀具，
//可是事实上，使用钝刀往往更容易出事，而利刀更为安全。

//开发使用场景:
//系统自带的方法功能不够，给系统自带的方法扩展一些功能，并且保持原有的功能。
//方式一:继承系统的类，重写方法.
//方式二:使用runtime,交换方法.
+ (void)load {
    // 获取imageWithName方法地址
    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，
    // 如果是类方法就使用class_getClassMethod()函数获取。
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    // 获取imageWithName方法地址
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageWithName, imageName);
    
    [NSMutableArray array];
    [NSArray array];
}

// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.
// 既能加载图片又能打印
+ (instancetype)imageWithName:(NSString *)name {
    NSLog(@"图片的名字为:%@",name);
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        NSLog(@"加载空的图片");
    }
    
    return image;
}

@end

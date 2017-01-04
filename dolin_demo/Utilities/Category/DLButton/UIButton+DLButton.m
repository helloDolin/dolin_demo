//
//  UIButton+DLButton.m
//  RealCustomButton
//
//  Created by dolin on 16/12/14.
//  Copyright © 2016年 dolin. All rights reserved.
//

#import "UIButton+DLButton.h"
#import <objc/runtime.h>

// PS：这些都可以写在@implementation中，但是写在外边跟明显区分
static const char *kTitleRectKey = "kTitleRectKey";
static const char *kImageRectKey = "kImageRectKey";

/**
 *  添加新方法，并将新方法与老方法的实现交换
 *  作用：新方法还是在调旧方法，旧方法调新方法都是 为了扩充老方法的实现，
 *  @param c         当前类
 *  @param originSEL 老方法
 *  @param newSEL    新方法
 */
void addMethod(Class c, SEL originSEL,SEL newSEL) {
    // 获取方法地址
    Method originMethod = class_getInstanceMethod(c, originSEL);
    Method newMethod = class_getInstanceMethod(c, newSEL);
    
    // runtime 添加新方法
    // 第一个参数：给哪个类添加方法
    // 第二个参数：添加方法的方法编号
    // 第三个参数：添加方法的函数实现（函数地址）
    // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
    BOOL isAddNewMethod = class_addMethod(c, originSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    
    if(isAddNewMethod){
        // 新方法添加成功：将新方法替换为旧方法
        class_replaceMethod(c, newSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }
    else {
        // 新方法添加失败：将新方法与旧方法实现交换
        method_exchangeImplementations(originMethod,newMethod);
    }
}

@implementation UIButton (DLButton)
#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

+ (void)load {
    addMethod(self, @selector(titleRectForContentRect:), @selector(new_titleRectForContentRect:));
    addMethod(self, @selector(imageRectForContentRect:), @selector(new_imageRectForContentRect:));
}

#pragma mark - method
- (CGRect)new_titleRectForContentRect:(CGRect)contentRect {
    if (!CGRectIsEmpty(self.dl_TitleRect) && !CGRectEqualToRect(self.dl_TitleRect, CGRectZero)) {
        return self.dl_TitleRect;
    }
    return [self new_titleRectForContentRect:contentRect];
}

- (CGRect)new_imageRectForContentRect:(CGRect)contentRect {
    if (!CGRectIsEmpty(self.dl_ImageRect) && !CGRectEqualToRect(self.dl_ImageRect, CGRectZero)) {
        return self.dl_ImageRect;
    }
    return [self new_imageRectForContentRect:contentRect];
}

#pragma mark - getter && setter
- (CGRect)dl_TitleRect {
    id obj = objc_getAssociatedObject(self, kTitleRectKey);
    return [obj CGRectValue];
}

- (void)setDl_TitleRect:(CGRect)dl_TitleRect {
    objc_setAssociatedObject(self, kTitleRectKey, [NSValue valueWithCGRect:dl_TitleRect], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)dl_ImageRect {
    id obj = objc_getAssociatedObject(self, kImageRectKey);
    return [obj CGRectValue];
}

- (void)setDl_ImageRect:(CGRect)dl_ImageRect {
    objc_setAssociatedObject(self, kImageRectKey, [NSValue valueWithCGRect:dl_ImageRect], OBJC_ASSOCIATION_RETAIN);
}

@end

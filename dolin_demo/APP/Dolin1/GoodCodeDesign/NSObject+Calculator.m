//
//  NSObject+Calculator.m
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import "NSObject+Calculator.h"
#import "CalculatorMaker.h"

@implementation NSObject (Calculator)

+ (NSInteger)makeCalc:(void(^)(CalculatorMaker *calculatorMaker))block {
    CalculatorMaker* obj = [[CalculatorMaker alloc]init];
    block(obj);
    return obj.result;
}

@end

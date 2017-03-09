//
//  NSObject+Calculator.h
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorMaker;

@interface NSObject (Calculator)

+ (NSInteger)makeCalc:(void(^)(CalculatorMaker *calculatorMaker))block;

@end

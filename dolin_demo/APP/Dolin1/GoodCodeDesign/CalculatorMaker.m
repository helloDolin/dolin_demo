//
//  CalculatorMaker.m
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker

- (CalculatorMaker *(^)(NSInteger))add {
    return ^CalculatorMaker* (NSInteger value) {
        _result += value;
        return self;
    };
}


- (CalculatorMaker *(^)(NSInteger))sub {
    return ^CalculatorMaker* (NSInteger value) {
        _result -= value;
        return self;
    };
}

- (CalculatorMaker *(^)(NSInteger))muilt {
    return ^CalculatorMaker* (NSInteger value) {
        _result *= value;
        return self;
    };
}

- (CalculatorMaker *(^)(NSInteger))divide {
    return ^CalculatorMaker* (NSInteger value) {
        _result /= value;
        return self;
    };
}

@end

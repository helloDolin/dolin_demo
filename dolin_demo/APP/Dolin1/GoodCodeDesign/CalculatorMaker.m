//
//  CalculatorMaker.m
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker

- (Calculate)add {
    return ^CalculatorMaker* (NSInteger value) {
        self->_result += value;
        return self;
    };
}


- (Calculate)sub {
    return ^CalculatorMaker* (NSInteger value) {
        self->_result -= value;
        return self;
    };
}

- (Calculate)muilt {
    return ^CalculatorMaker* (NSInteger value) {
        self->_result *= value;
        return self;
    };
}

- (Calculate)divide {
    return ^CalculatorMaker* (NSInteger value) {
        self->_result /= value;
        return self;
    };
}

@end

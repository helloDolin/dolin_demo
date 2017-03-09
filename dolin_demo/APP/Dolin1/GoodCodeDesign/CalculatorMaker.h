//
//  CalculatorMaker.h
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorMaker : NSObject

@property (nonatomic, assign) NSInteger result;

- (CalculatorMaker *(^)(NSInteger))add;
- (CalculatorMaker *(^)(NSInteger))sub;
- (CalculatorMaker *(^)(NSInteger))muilt;
- (CalculatorMaker *(^)(NSInteger))divide;

@end

//
//  CalculatorMaker.h
//  test_链式编程
//
//  Created by dolin on 17/3/6.
//  Copyright © 2017年 dolin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CalculatorMaker : NSObject

typedef CalculatorMaker* (^Calculate)(NSInteger num);

@property (nonatomic, assign) NSInteger result;

- (Calculate)add;
- (Calculate)sub;
- (Calculate)muilt;
- (Calculate)divide;

@end

//
//  Test.h
//  dolin_demo
//
//  Created by dolin on 17/2/9.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Test : NSObject

SINGLETON_FOR_HEADER(Test);

- (void)testWithBlock:(void(^)()) block;
@end

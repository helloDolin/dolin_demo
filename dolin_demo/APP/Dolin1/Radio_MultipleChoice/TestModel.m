//
//  TestModel.m
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "TestModel.h"

@interface TestModel ()

@end

@implementation TestModel

+ (instancetype)testModelWithTitle:(NSString*)title isSelected:(BOOL)isSelected {
    TestModel *obj = [TestModel new];
    obj.title = title;
    obj.isSelected = isSelected;
    return obj;
}

@end

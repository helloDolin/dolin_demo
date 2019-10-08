//
//  TestModel.h
//   
//
//  Created by dolin999 on 2019/10/8.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)testModelWithTitle:(NSString*)title isSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END

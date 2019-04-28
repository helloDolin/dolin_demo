//
//  DLFoldCellModel.m
//   
//
//  Created by Dolin on 2019/4/28.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "DLFoldCellModel.h"

@implementation DLFoldCellModel

+ (instancetype)modelWithDic:(NSDictionary*)dic {
    DLFoldCellModel* model = [DLFoldCellModel new];
    model.text = dic[@"text"];
    model.level = dic[@"level"];
    model.belowCount = 0;
    
    model.subModels = [NSMutableArray array];
    NSArray* submodels = dic[@"subModels"];
    [submodels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DLFoldCellModel* subModel = [DLFoldCellModel modelWithDic:obj];
        subModel.superModel = model;
        [model.subModels addObject:subModel];
    }];
    
    return model;
}

- (NSArray*)open {
    NSArray* subModels = self.subModels;
    self.subModels = nil;
    self.belowCount = subModels.count;
    return subModels;
}

- (void)closeWithSubModels:(NSArray*)subModels {
    self.subModels = [NSMutableArray arrayWithArray:subModels];
    self.belowCount = 0;
}

- (void)setBelowCount:(NSInteger)belowCount {
    self.superModel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

@end

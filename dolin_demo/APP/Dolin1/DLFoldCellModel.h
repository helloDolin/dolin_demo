//
//  DLFoldCellModel.h
//   
//
//  Created by Dolin on 2019/4/28.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 折叠cell模型
 */
@interface DLFoldCellModel : NSObject

@property(nonatomic,copy)NSString* text;
@property(nonatomic,copy)NSString* level;
@property(nonatomic,assign)NSInteger belowCount;
@property(nonatomic,strong)NSMutableArray<DLFoldCellModel*>* _Nullable  subModels;
@property(nonatomic,strong)DLFoldCellModel* superModel;

+ (instancetype)modelWithDic:(NSDictionary*)dic;
- (NSArray*)open;
- (void)closeWithSubModels:(NSArray*)subModels;

@end

NS_ASSUME_NONNULL_END

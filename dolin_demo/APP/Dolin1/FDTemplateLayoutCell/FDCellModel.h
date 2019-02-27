//
//  FDCellModel.h
//  dolin_demo
//
//  Created by Dolin on 2019/2/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDCellModel : NSObject

@property(nonatomic,copy)NSString* userIconUrl;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* shuoshuo;
@property(nonatomic,strong)NSArray<NSString*>* urls;

@end

NS_ASSUME_NONNULL_END

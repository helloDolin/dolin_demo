//
//  DLTabModel.h
//  dolin_demo
//
//  Created by 廖少林 on 2022/3/17.
//  Copyright © 2022 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTabModel : NSObject

@property (nonatomic, copy) NSString *norTitle;     // 正常文案
@property (nonatomic, copy) NSString *selTitle;     // 选中文案
@property (nonatomic, copy) NSString *norImageName; // 正常图片
@property (nonatomic, copy) NSString *selImageName; // 选中图片

@end

NS_INLINE DLTabModel *DLTabInfoModel(NSString *norTitle,
                                     NSString *_Nullable selTitle,
                                     NSString *norImageName,
                                     NSString *_Nullable selImageName) {
    
    DLTabModel *item = [[DLTabModel alloc] init];
    item.norTitle = norTitle;
    item.selTitle = selTitle ?: norTitle;
    item.norImageName = norImageName;
    item.selImageName = selImageName ?: norImageName;
    return item;
}

NS_ASSUME_NONNULL_END

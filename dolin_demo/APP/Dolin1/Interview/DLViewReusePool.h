//
//  DLViewReusePool.h
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 实现重用机制
@interface DLViewReusePool : NSObject

/// 从重用池中取
- (UIView*)dequeueReuseableView;

/// 向重用池添加
/// @param view <#view description#>
- (void)addUsingView:(UIView*)view;

/// 将当前使用的视图移动到可重用队列
- (void)reset;
@end

NS_ASSUME_NONNULL_END

//
//  DLInterviewVC.h
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 1.重用池
 2.多读单写
 3.改变响应区域
 4.NTP 协议 时间同步协议
 5.http 事务：一起完成的 req、res
   http 1.1 的性能瓶颈：在同一个 TCP 上发起多个 http 事务，但是是串行的，因为其无状态只能串行，http2 解决了这个问题
   http2 做了头部压缩
   
 */
@interface DLInterviewVC : UIViewController

@end

NS_ASSUME_NONNULL_END

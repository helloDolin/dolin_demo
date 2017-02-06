//
//  BlockAlertView.h
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 取消方法弃用告警
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface BlockAlertView : UIAlertView

+ (void)alertWithTitle:(NSString*)title
               message:(NSString*)message
    cancelBtnWithTitle:(NSString*)cancelBtnTitle
           cancelBlock:(void(^)())cancelBlock
confirmButtonWithTitle:(NSString*)confirmBtnTitle
          confirmBlock:(void(^)())confirmBlock;

@end

#pragma clang diagnostic pop

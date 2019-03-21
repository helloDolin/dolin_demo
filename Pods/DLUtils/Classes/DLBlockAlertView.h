//
//  BlockAlertView.h
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBlockAlertView : UIAlertView

+ (void)alertWithTitle:(NSString*)title
               message:(NSString*)message
    cancelBtnWithTitle:(NSString*)cancelBtnTitle
           cancelBlock:(void(^)(void))cancelBlock
confirmButtonWithTitle:(NSString*)confirmBtnTitle
          confirmBlock:(void(^)(void))confirmBlock;

@end

//
//  BlockAlertView.m
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "BlockAlertView.h"

@interface BlockAlertView()<UIAlertViewDelegate>

@property (nonatomic, copy) void (^cancelBlock)();
@property (nonatomic, copy) void (^confirmBlock)();

@end

@implementation BlockAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelBlock confirmButtonWithTitle:(NSString *)confirmTitle confirmBlock:(void (^)())confirmBlock {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
    if (self) {
        _cancelBlock = cancelBlock;
        _confirmBlock = confirmBlock;
    }
    return self;
}

+ (void)alertWithTitle:(NSString*)title
               message:(NSString*)message
    cancelBtnWithTitle:(NSString*)cancelBtnTitle
           cancelBlock:(void(^)())cancelBlock
confirmButtonWithTitle:(NSString*)confirmBtnTitle
          confirmBlock:(void(^)())confirmBlock {
    BlockAlertView* blockAlertView = [[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelBtnTitle cancelBlock:cancelBlock confirmButtonWithTitle:confirmBtnTitle confirmBlock:confirmBlock];
    [blockAlertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex != buttonIndex ) {
        if (self.confirmBlock) {
            self.confirmBlock();
        }
    }
    else {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
}

@end

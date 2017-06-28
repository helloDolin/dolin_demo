//
//  PhotoAlbumCell.m
//  MerchantManagement
//
//  Created by dolin on 2017/3/17.
//  Copyright © 2017年 boqii. All rights reserved.
//

#import "PhotoAlbumCell.h"

@implementation PhotoAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)checkBtnAction:(UIButton *)sender {
    if (self.checkBtnBlock) {
        self.checkBtnBlock(sender);
    }
}


/**
 hitTest 代码表现大概如下

 @param point
 @param event
 @return
 */
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled || self.hidden || self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:point withEvent:event]) {
        for (UIView* subView in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subView convertPoint:point fromView:self];
            UIView *hitTestView = [subView hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController* vc = [self viewController];
    NSLog(@"==============%@",NSStringFromClass(vc.class));
}

@end

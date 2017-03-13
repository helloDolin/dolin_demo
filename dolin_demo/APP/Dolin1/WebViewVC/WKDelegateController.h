//
//  WKDelegateController.h
//  dolin_demo
//
//  Created by dolin on 2017/3/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController <WKScriptMessageHandler>

@property (nonatomic,weak) id<WKDelegate> delegate;

@end

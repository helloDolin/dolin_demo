//
//  NoteListDelegate.h
//  dolin_demo
//
//  Created by dolin on 2017/5/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NoteListDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIViewController *vc;

@end

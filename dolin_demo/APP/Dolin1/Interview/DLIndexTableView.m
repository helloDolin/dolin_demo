//
//  DLIndexTableView.m
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import "DLIndexTableView.h"
#import "DLViewReusePool.h"

@interface DLIndexTableView()
{
    UIView *containerView;
    DLViewReusePool *reusePool;
}
@end

@implementation DLIndexTableView

/// 重写 reloadData
- (void)reloadData {
    [super reloadData];
    
    if (containerView == nil) {
        containerView = [[UIView alloc]initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor redColor];
        // 避免索引条随着 table 移动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reusePool == nil) {
        reusePool = [[DLViewReusePool alloc] init];
    }
    
    // 标记所有视图为可重用状态
    [reusePool reset];
    
    // reload 字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    // 获取字母索引条的显示内容
    NSArray <NSString*> *arrTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
    }
    if (!arrTitles || arrTitles.count <= 0) {
        containerView.hidden = YES;
        return;
    }
    
    NSInteger count = arrTitles.count;
    CGFloat btnWidth = 60;
    CGFloat btnHeight = self.frame.size.height / count;
    
    for (int i = 0; i< count; i++) {
        NSString *title = arrTitles[i];
        UIButton *btn = (UIButton*)[reusePool dequeueReuseableView];
        if (btn == nil) {
            btn = [[UIButton alloc]initWithFrame:CGRectZero];
            btn.backgroundColor = [UIColor blueColor];
            [reusePool addUsingView:btn];
            NSLog(@"向重用池添加 btn");
        } else {
            NSLog(@"btn 重用了");
        }
        
        [containerView addSubview:btn];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0, i * btnHeight, btnWidth, btnHeight)];
    }
    containerView.hidden = NO;
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - btnWidth, self.frame.origin.y, btnWidth, self.frame.size.height);
}

@end

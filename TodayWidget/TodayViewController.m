//
//  TodayViewController.m
//  TodayWidget
//
//  Created by dolin on 2017/5/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NoteListDelegate.h"

@interface TodayViewController () <NCWidgetProviding>
{
    NoteListDelegate *tableDelegate;
}

@property (weak, nonatomic) IBOutlet UITableView *noteTable;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _noteTable.estimatedRowHeight = 44.0;
    tableDelegate = [[NoteListDelegate alloc] init];
    tableDelegate.vc = self;
    _noteTable.delegate = tableDelegate;
    _noteTable.dataSource = tableDelegate;
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(0, 300);
    }else{
        self.preferredContentSize = maxSize;
    }
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (IBAction)addBtnAction:(UIButton *)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"todaywidget://add"] completionHandler:nil];
}

@end

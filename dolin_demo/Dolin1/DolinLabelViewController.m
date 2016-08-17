//
//  KeyWordHighLightVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinLabelViewController.h"
#import "DolinLabel.h"

@interface DolinLabelViewController ()

@end

@implementation DolinLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * content = @"DolinLabelTest==DolinLabelTest阿斯顿发的说法的是否 ";
    // test段间距
    content = [NSString stringWithFormat:@"%@\n%@", content, content];
    
    DolinLabel* contentLab = [[DolinLabel alloc] initWithCharacterSpacing:5 linesSpacing:5 paragraphSpacing:5];
    contentLab.backgroundColor = RANDOM_UICOLOR;
    contentLab.text = content;
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.textColor = [UIColor whiteColor];
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.numberOfLines = 0;
    CGFloat labelWidth = SCREEN_WIDTH - 10 * 2;
    CGFloat labelHeight = [contentLab getAttributedStringHeightByWidthValue:labelWidth];
    contentLab.frame = CGRectMake(10, 0 + 64, labelWidth, labelHeight);
    [self.view addSubview:contentLab];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

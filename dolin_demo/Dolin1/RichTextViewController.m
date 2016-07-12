//
//  RichTextViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "RichTextViewController.h"

@interface RichTextViewController ()

@end

@implementation RichTextViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RANDOM_UICOLOR;
    
    UILabel *spacingLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    spacingLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈饭卡上的话费卡还得上课发哈神的客服哈打开司法考试的理解啊登录即可法拉第减肥垃圾堆里放假啊来的快解放啦江东父老卡就到了放假啊登录开发及阿里的肌肤轮廓阿迪和法律上的价格啦可是大驾光临卡是大驾光临卡手机丢了卡世界的理解啊收到了看风景啊索朗多吉法律快速的减肥啦数据的法律框架阿萨德了看风景啊索朗多吉发生肯德基放辣椒地方";
    spacingLabel.numberOfLines = 0;
    spacingLabel.font  = [UIFont systemFontOfSize:12];
    spacingLabel.textColor = [UIColor whiteColor];
    spacingLabel.backgroundColor = [UIColor orangeColor];
    
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:50];
    //字间距
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:spacingLabel.text attributes:@{NSKernAttributeName : @(5.5f)}];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, spacingLabel.text.length)];
    
    spacingLabel.attributedText = attributedString;
    
//    CGSize size = CGSizeMake(SCREEN_WIDTH, 500000);
    
//    CGSize labelSize = [spacingLabel sizeThatFits:size];
    
    CGSize labelSize = [spacingLabel sizeThatFits:CGSizeMake(spacingLabel.frame.size.width, MAXFLOAT)];
    
    spacingLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    
    [self.view addSubview:spacingLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  getter
@end

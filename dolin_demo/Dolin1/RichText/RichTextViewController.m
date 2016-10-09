//
//  RichTextViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "RichTextViewController.h"

static NSString* kStr = @"对酒当歌，人生几何？对酒当歌，人生几何？对酒当歌，人生几何？对酒当歌，人生几何？对酒当歌，人生几何？\n譬如朝露，去日苦多。\n慨当以慷，忧思难忘。\n何以解忧？惟有杜康。\n青青子衿，悠悠我心。";

@interface RichTextViewController ()
{
    UILabel* _testLabel;
}

@end

@implementation RichTextViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 20, SCREEN_WIDTH, 0)];
    _testLabel.numberOfLines = 0;
    _testLabel.backgroundColor = [UIColor orangeColor];
    
    
    [self studyAttributeString2];
    [self.view addSubview:_testLabel];
}

#pragma mark - method

- (void)studyAttributeString2 {
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:kStr];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraph.lineSpacing = 1;
    //段落间距 \n与\n的间距
    paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //首行缩进
    paragraph.firstLineHeadIndent = 20;
    
    // 其余行缩进
//    paragraph.headIndent = 20.0f;
    
    

    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attrStr.length)];
    
    [attrStr addAttribute:NSFontAttributeName value:_testLabel.font range:NSMakeRange(0, attrStr.length)];
    
    //字间距
    [attrStr addAttribute:NSKernAttributeName value:@(5.0f) range:NSMakeRange(0, attrStr.length)];
    
    _testLabel.attributedText = attrStr;
    
    // 试验证明size1并不可靠，实际项目中用size2或者size3即可
    // 特别注意：需要设置所有String的字体大小，才能正确求到高度
    CGSize size1 =  attrStr.size;
    CGSize size2 = [attrStr  boundingRectWithSize:CGSizeMake(SCREEN_WIDTH,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    
    // size3需要给label attributeText赋值后才可以求，而且比size1、2方式值略大
    CGSize size3 = [_testLabel sizeThatFits:CGSizeMake(_testLabel.frame.size.width, MAXFLOAT)];
    
    // 重新设置label的高度
    _testLabel.height = size2.height;
}

/**
 * iOS 6之前：CoreText,纯C语言,极其蛋疼
 * iOS 6开始：NSAttributedString,简单易用
 * iOS 7开始：TextKit,功能强大,简单易用
   UILabel、UITextField、UITextView都有NSAttributedString属性
 
 需要注意的是，你不能直接修改已有的AttributedString, 你需要把它copy出来，修改后再进行设置：
 
 NSMutableAttributedString *labelText = [myLabel.attributedText mutableCopy];
 [labelText setAttributes:...];
 myLabel.attributedText = labelText;
 
 设置 hyphenationFactor 属性就可以启用断字。
 
 
 */
- (void)studyAttributeString {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"哈哈123456"];
    
    // 添加各种attribute
    [string setAttributes:@{
                                NSForegroundColorAttributeName:[UIColor blueColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:30],
                                NSBackgroundColorAttributeName:[UIColor redColor]
                            }
                    range:NSMakeRange(0, 2)];
    
    
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(6, 2)];
    [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(6, 2)];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"MT"];
    attach.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    
    [string appendAttributedString:attachString];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"789"]];
    
    _testLabel.attributedText = string;
}

#pragma mark -  getter
@end

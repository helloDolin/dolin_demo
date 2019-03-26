//
//  PwdTextFieldBugViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "PwdTextFieldBugViewController.h"

@interface PwdTextFieldBugViewController ()
{
    UIScreenEdgePanGestureRecognizer* _pan;
    UIPercentDrivenInteractiveTransition* _interaction;
}

@property(nonatomic,strong)UIButton* btn;
@property(nonatomic,strong)UITextField* textField;

@end

@implementation PwdTextFieldBugViewController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self.view addSubview:self.btn];
    [self.view addSubview:self.textField];
    
    _pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    _pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_pan];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/2000.0;
    self.view.layer.transform = transform;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)sender {
    CGFloat progress = (-1 * [sender translationInView:sender.view].x) / self.view.width;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _interaction = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [_interaction updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (progress >= 0.5) { // 超过半个屏幕
                [_interaction finishInteractiveTransition];
            }
            else {
                [_interaction cancelInteractiveTransition];
            }
            _interaction = nil;
        }
        default:
            break;
    }
}



#pragma mark -  getter 
- (void)btnAction {
    self.textField.secureTextEntry = !self.textField.secureTextEntry;
    NSString* txt = self.textField.text;
    // 先给其一个乱七八糟的值，再赋值就解决这个bug了，苹果设计的缺陷
    // 苹果已修复此bug
    self.textField.text = @"";
    self.textField.text = txt;
    if (self.textField.isSecureTextEntry) {
        [_btn setTitle:@"显示密码" forState:UIControlStateNormal];
    }
    else {
        [_btn setTitle:@"隐藏密码" forState:UIControlStateNormal];
    }
}

- (UIButton*)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT,SCREEN_WIDTH , 50);
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn setTitle:@"显示密码" forState:UIControlStateNormal];
        _btn.tintColor = [UIColor whiteColor];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UITextField*)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(120,NAVIGATION_BAR_HEIGHT + 50 + 30, 150, 30)];
        [_textField setBorderStyle:UITextBorderStyleBezel];
        _textField.placeholder = @"password";
        _textField.secureTextEntry = YES;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        // 定义文本自动大小写样式。UITextAutocapitalizationTypeNone关闭自动大写。
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

@end

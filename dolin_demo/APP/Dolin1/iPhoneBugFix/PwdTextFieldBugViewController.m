//
//  PwdTextFieldBugViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "PwdTextFieldBugViewController.h"
#import "PopTransition.h"

@interface PwdTextFieldBugViewController ()<UINavigationControllerDelegate>
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
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    if (operation == UINavigationControllerOperationPop) {
        return [PopTransition new];
    }
    return nil;
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
    self.textField.text = @""; //先给其一个乱七八糟的值，再赋值就解决这个bug了，苹果设计的缺陷
    self.textField.text = txt;
}

- (UIButton*)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(0, 64,SCREEN_WIDTH , 50);
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn setTitle:@"test" forState:UIControlStateNormal];
        _btn.tintColor = [UIColor whiteColor];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UITextField*)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 80.0f + 64, 150.0f, 30.0f)];
        [_textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
        
        _textField.placeholder = @"password"; //默认显示的字
        
        _textField.secureTextEntry = YES; //密码
        
        // 定义文本是否使用iPhone的自动更正功能。
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        // 定义文本自动大小写样式。UITextAutocapitalizationTypeNone关闭自动大写。
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        
//        _textField.delegate = self;
    }
    return _textField;
}

@end

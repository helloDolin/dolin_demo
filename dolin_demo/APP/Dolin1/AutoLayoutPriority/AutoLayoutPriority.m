//
//  InterviewVC.m
//  dolin_demo
//
//  Created by dolin on 2017/4/18.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "AutoLayoutPriority.h"

@interface AutoLayoutPriority ()

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UILabel *rightLbl;

@end

@implementation AutoLayoutPriority

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 监听设备自动旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    [self.view addSubview:self.testView];
    
    [self.view addSubview:self.leftLbl];
    [self.view addSubview:self.rightLbl];
    
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self->_rightLbl.mas_left).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
    }];
    
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self->_leftLbl.mas_top);
        make.left.equalTo(self->_leftLbl.mas_right).offset(10);
    }];
    
    // 设置左边label压缩优先级低于默认750，所以当有压缩情景时，右边全部显示，左边...
    [_leftLbl setContentCompressionResistancePriority:700
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 通知设备旋转了
- (void)orientChange:(NSNotification *)noti {
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    switch (orient) {
        case UIDeviceOrientationPortrait:
           
            break;
        case UIDeviceOrientationLandscapeLeft:
            
            break;
        case UIDeviceOrientationLandscapeRight:
            
            break;
        default:
            break;
    }
}


- (UIView*)testView {
    if (!_testView) {
        _testView = [[UIView alloc]init];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

- (UILabel*)leftLbl {
    if (!_leftLbl) {
        _leftLbl = [[UILabel alloc]init];
        _leftLbl.text = @"adsfasdfadsfasadsfasdfadsfasadsfasdfadsfas";
    }
    return _leftLbl;
}

- (UILabel*)rightLbl {
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc]init];
        _rightLbl.text = @"123123123123";
    }
    return _rightLbl;
}

@end

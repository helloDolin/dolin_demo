//
//  InterviewVC.m
//  dolin_demo
//
//  Created by dolin on 2017/4/18.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "InterviewVC.h"

@interface InterviewVC ()

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UILabel *rightLbl;

@end

@implementation InterviewVC

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
        make.right.equalTo(_rightLbl.mas_left).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
    }];
    
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(_leftLbl.mas_top);
    }];
    
    [_rightLbl setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)updateTestViewConstraint {
    BOOL isPortrait = NO;
    CGFloat superW = self.view.width;
    CGFloat superH = self.view.height;
    
    // 竖屏
    if (superW / superH < 1) {
        isPortrait = YES;
    }
    
    [_testView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.view).with.priorityLow();
        if (isPortrait) {
            make.height.equalTo(self.view.mas_width).multipliedBy(3 / 4.0); // 注意这里需要float类型
        }
        else {
            make.width.equalTo(self.view.mas_height).multipliedBy(4.0 / 3);
        }
        make.center.equalTo(self.view);
    }];
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
            [self updateTestViewConstraint];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self updateTestViewConstraint];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self updateTestViewConstraint];
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
        _leftLbl.text = @"adsfasdfadsfas";
    }
    return _leftLbl;
}

- (UILabel*)rightLbl {
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc]init];
        _rightLbl.text = @"奥德赛发送到发送到发送到发送到发送到发送到发多少";
        _rightLbl.numberOfLines = 1;
    }
    return _rightLbl;
}

@end

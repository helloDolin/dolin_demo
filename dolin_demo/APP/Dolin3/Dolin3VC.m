//
//  Dolin3VC.m
//  dolin_demo
//
//  Created by dolin on 16/8/30.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin3VC.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

@interface Dolin3VC ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) FlutterViewController *flutterViewController;

@end

@implementation Dolin3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addObserver];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(dismissFlutterVC)
        name:@"dismiss_current_vc"
      object:nil];
}

- (void)dismissFlutterVC {
    [self.flutterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonTap {
    FlutterEngine *flutterEngine =
        ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    self.flutterViewController =
        [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    self.flutterViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:self.flutterViewController animated:YES completion:nil];
}

#pragma mark - getter
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitle:@"jump 2 flutter page" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = RANDOM_UICOLOR.CGColor;
     }
    return _btn;
}

@end

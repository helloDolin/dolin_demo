//
//  Dolin3VC.m
//  dolin_demo
//
//  Created by dolin on 16/8/30.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin3VC.h"

@interface Dolin3VC ()

@property (nonatomic, strong) UIView *customNavView;

@end

@implementation Dolin3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = RANDOM_UICOLOR;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customNavView];
}

#pragma mark - getter
- (UIView *)customNavView {
    if (!_customNavView) {
        _customNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,[UIApplication sharedApplication].statusBarFrame.size.height + 44)];
        _customNavView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbl = [[UILabel alloc]init];
        lbl.text = @"DOLIN3";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:18];
        lbl.textColor = [UIColor blackColor];
        [_customNavView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.centerX.equalTo(_customNavView);
        }];
    }
    return _customNavView;
}

@end

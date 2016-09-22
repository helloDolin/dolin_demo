//
//  SheViewController.m
//  dolin_demo
//
//  Created by dolin on 16/9/22.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SheViewController.h"

@interface SheViewController ()

@property (nonatomic,strong)UIImageView* imgView;

@end

@implementation SheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imgView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark - event
- (void)tapAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setter
- (UIImageView*)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _imgView.image = JPGIMAGE(@"she");
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.userInteractionEnabled = YES; // 设置为YES，要不手势没用
        
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_imgView addGestureRecognizer:gestureRecognizer];
    }
    return _imgView;
}

@end

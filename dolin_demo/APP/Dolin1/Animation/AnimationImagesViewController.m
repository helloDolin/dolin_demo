//
//  AnimationImagesViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/12.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationImagesViewController.h"

@interface AnimationImagesViewController ()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *animationImgView;

@end

@implementation AnimationImagesViewController

#pragma mark -  life circle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.animationImgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  getter 
- (UIImageView*)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgImg"]];
        _bgImgView.alpha = 0.8;
        _bgImgView.frame = CGRectMake(0, NavigtationBarHeight, 60, 60);
        _bgImgView.center = self.view.center;
    }
    return _bgImgView;
}

- (UIImageView*)animationImgView {
    if (!_animationImgView) {
        _animationImgView = [[UIImageView alloc]init];
        _animationImgView.frame = CGRectMake(0, NavigtationBarHeight, 43, 43);
        _animationImgView.center = self.view.center;

        
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString* imgName = [NSString stringWithFormat:@"%d.png",i +1 ];
            [arr addObject:[UIImage imageNamed:imgName]];
        }
        
        _animationImgView.animationImages = arr;
        // 设置循环次数
        _animationImgView.animationRepeatCount = -1;
        _animationImgView.animationDuration = 2;
        [_animationImgView startAnimating];
    }
    return _animationImgView;
}


@end

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

@property (nonatomic, strong) UIView *containerView;

@end

@implementation AnimationImagesViewController

#pragma mark -  life circle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.animationImgView];
    [self.view addSubview:self.containerView];
    
    // 新的布局方式学习
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.centerX.equalTo(self.view);
        make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width-20);
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor orangeColor];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"MT"];
        [_containerView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_containerView).offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerY.equalTo(_containerView);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = @"这是阿三冲击红进口付出dsk红进口付出ds口付出dsk红进口付出dskjfhks口付kjfhks口付出dskj红进口付出dskjfhks口付出dskjjfhks口付出dskjfhd付出dsk红进口付出ds口付出dsk红进口付出dskjfhks口付kjfhks口付出dskj红进口付出dskjfhks口付出dskjjfhks口付出dskjfhdjfhdksjhfdk";
        [_containerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(imgView.mas_left).offset(-20);
            make.left.equalTo(_containerView).offset(0);
            make.bottom.top.equalTo(_containerView).offset(0);
            make.height.mas_greaterThanOrEqualTo(100);
        }];
    }
    return _containerView;
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

//
//  CGAffineTransformStudy_VC.m
//  dolin_demo
//
//  Created by dolin on 16/9/23.
//  Copyright © 2016年 shaolin. All rights reserved.
//

/**
    放射变换矩阵:从属于CoreGraphics框架
 
    总体来说就三种：平移、旋转、缩放，对应变化一次或一直可变化
 
    矩阵的转换
 
    make：是针对视图的原定最初位置的中心点为起始参照进行相应操作的
  
    CGAffineTransformIdentity
     [ 1 0 0
       0 1 0
       0 0 1]
 
    CGAffineTransformMakeScale(-1.0, 1.0);//水平翻转
 
    CGAffineTransformMakeScale(1.0,-1.0);//垂直翻转
 
 
 */

#import "CGAffineTransformStudy_VC.h"

@interface CGAffineTransformStudy_VC ()
{
    UIImageView* _imgView;
}

@end

@implementation CGAffineTransformStudy_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imgView.center = self.view.center;
    _imgView.image = [UIImage imageNamed:@"MT"];
    [self.view addSubview:_imgView];
    
    // 
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 64, 375, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"hello" forState:UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction {

//    [self translate];
//    [self rotate1]; // 旋转传的是弧度 arc
//    [self rotate2];
//    [self scale];
    
//    [self translateAndRotateAndScale];
    
//    _imgView.transform = [self CGAffineTransformMakeShear:1 y:0];
    
    // test
    [UIView animateWithDuration:5 animations:^{
        CGAffineTransform t = CGAffineTransformMakeScale(1.0, -1.0);
        _imgView.transform = t;
    }];
    
}

- (CGAffineTransform)CGAffineTransformMakeShear:(CGFloat) x y:(CGFloat) y {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = x;
    transform.b = y;
    return transform;
    
}


- (void)translateAndRotateAndScale {
    CGAffineTransform t = CGAffineTransformMakeScale(1.0, 1.0);
    t = CGAffineTransformRotate(t, M_PI);
    t = CGAffineTransformTranslate(t, 0, 60);
    _imgView.transform = t;
}

- (void)scale {
    // 仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果
    _imgView.transform = CGAffineTransformMakeScale(1.5, 1.5);
}

- (void)translate {
    // 每次变化都是以上一次的状态（CGAffineTransform t）进行的变化，所以可以多次变化
    CGAffineTransform transform = _imgView.transform;
    _imgView.transform = CGAffineTransformTranslate(transform, 0, 10);
}

- (void)rotate2 {
    CGAffineTransform t = _imgView.transform;
    [UIView animateWithDuration:2 animations:^{
        _imgView.transform = CGAffineTransformRotate(t, M_PI);
    }];
}

- (void)rotate1 {
    static BOOL b = YES;
    if (b) {
        // CGAffineTransformMakeRotation
        // 只能变化一次，因为这种方式的变化始终是以最原始的状态值进行变化的，所以只能变化一次
        _imgView.transform = CGAffineTransformMakeRotation(M_PI);
        
    } else {
        // CGAffineTransformIdentity
        // 清空所有的设置的transform(一般和动画配合使用，只能使用于transfofrm设置的画面)
        _imgView.transform = CGAffineTransformIdentity;
    }
    b = !b;
}

@end

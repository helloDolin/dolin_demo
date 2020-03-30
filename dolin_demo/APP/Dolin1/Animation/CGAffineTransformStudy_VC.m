//
//  CGAffineTransformStudy_VC.m
//  dolin_demo
//
//  Created by dolin on 16/9/23.
//  Copyright © 2016年 shaolin. All rights reserved.
//

/**
    🦍🦍🦍
    仿射变换矩阵:从属于CoreGraphics框架
    总体来说就三种：平移、旋转、缩放，对应变化一次或一直可变化
    动画每次都可以叠加，要注意的是叠加每次的动画需相同，比如向y轴方向移动，就一直叠加y的移动，如果这个时候旋转，就懵逼了（暂时这么理解）
 
    CGAffineTransformMakeScale(-1.0, 1.0); // 水平翻转
    CGAffineTransformMakeScale(1.0,-1.0); // 垂直翻转
 
    矩阵的转换(暂时不深入)
    make：是针对视图的原定最初位置的中心点为起始参照进行相应操作的
    CGAffineTransformIdentity
     [ 1 0 0
       0 1 0
       0 0 1]
 */

#import "CGAffineTransformStudy_VC.h"

static const NSTimeInterval kAnimationTime = 1.0;

@interface CGAffineTransformStudy_VC ()

@property(nonatomic,assign)NSInteger clickCount;
@property(nonatomic,strong)UIView *testView;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation CGAffineTransformStudy_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.clickCount = 1;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    _testView.center = self.view.center;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _testView.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0.3, @0.5, @0.6];
    gradientLayer.colors = [NSArray arrayWithObjects:
                       (id)[UIColor redColor].CGColor,
                       (id)[UIColor greenColor].CGColor,
                       (id)[UIColor blueColor].CGColor,
                       nil];
    [_testView.layer addSublayer:gradientLayer];
    [self.view addSubview:_testView];
    
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 100);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn setTitle:@"translate" forState:UIControlStateNormal];
    _btn.tintColor = [UIColor whiteColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnAction {
    if (self.clickCount == 1) {
        [self translate];
    } else if (self.clickCount == 2){
        [self rotate];
    } else if (self.clickCount == 3){
        [self recover];
        self.clickCount = 0;
    }
    self.clickCount ++;
}

- (void)translate {
    [UIView animateWithDuration:kAnimationTime animations:^{
        // 每次变化都是以上一次的状态（self->_testView.transform）进行的变化，所以可以多次变
        self->_testView.transform = CGAffineTransformTranslate(self->_testView.transform,0,100);
        self->_btn.enabled = NO;
    } completion:^(BOOL finished) {
        [self recover];
    }];
}

- (void)rotate {
    [UIView animateWithDuration:kAnimationTime animations:^{
        self->_btn.enabled = NO;
        self->_testView.transform = CGAffineTransformRotate(self->_testView.transform, M_PI_2);
    } completion:^(BOOL finished) {
        self->_btn.enabled = YES;
    }];
}

- (void)recover {
    // CGAffineTransformIdentity
    // 清空所有的设置的transform(一般和动画配合使用，只能使用于Transform设置的画面)
    [UIView animateWithDuration:kAnimationTime animations:^{
        self->_testView.transform = CGAffineTransformIdentity;
        self->_btn.enabled = NO;
    } completion:^(BOOL finished) {
        self->_btn.enabled = YES;
    }];
}

- (void)setClickCount:(NSInteger)clickCount {
    _clickCount = clickCount;
    if (_clickCount == 0) {
        [_btn setTitle:@"translate" forState:UIControlStateNormal];
    } else if (_clickCount == 2){
        [_btn setTitle:@"rotate" forState:UIControlStateNormal];
    } else if (_clickCount == 3){
        [_btn setTitle:@"recover" forState:UIControlStateNormal];
    }
}

@end

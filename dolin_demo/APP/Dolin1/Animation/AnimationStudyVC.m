//
//  AnimationStudyVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/22.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationStudyVC.h"
#import "MMPlaceHolder.h"
//#import "NSArray+MASAdditions.h"

@interface AnimationStudyVC ()
{
    UIView* _testView;
}
@end

@implementation AnimationStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 50, 50)];
    _testView.center = self.view.center;
    _testView.backgroundColor = RANDOM_UICOLOR;
    [self.view addSubview:_testView];
    [self setupBottomView];
}

- (void)setupBottomView {
    UIView* bottomView = [UIView new];
    bottomView.backgroundColor = RANDOM_UICOLOR;
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
    }];
   
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = RANDOM_UICOLOR;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:[NSString stringWithFormat:@"基本动画"] forState:UIControlStateNormal];
    btn1.tag = 200;
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = RANDOM_UICOLOR;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:[NSString stringWithFormat:@"关键帧动画"] forState:UIControlStateNormal];
    btn2.tag = 201;
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = RANDOM_UICOLOR;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:[NSString stringWithFormat:@"组合动画"] forState:UIControlStateNormal];
    btn3.tag = 202;
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:btn1];
    [bottomView addSubview:btn2];
    [bottomView addSubview:btn3];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[btn2,btn3,bottomView]);
        make.height.equalTo(bottomView);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(btn1);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(btn1);
    }];
    
    // masonry自带等间距
    [@[btn1,btn2,btn3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    
    [btn1 showPlaceHolder];
}

- (void)animate0 {
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"position"];
    ba.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    ba.duration = 2;
    ba.autoreverses = YES;
    ba.removedOnCompletion = NO;
    ba.fillMode = kCAFillModeForwards;
    [_testView.layer addAnimation:ba forKey:nil];
}

- (void)animate1 {
    CAKeyframeAnimation *frameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue* value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue* value2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue* value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    frameAni.values = @[value1,value2,value3];
    frameAni.duration = 2;
    frameAni.removedOnCompletion = NO;
    frameAni.fillMode = kCAFillModeForwards;
    [_testView.layer addAnimation:frameAni forKey:nil];
}

- (void)animate2 {
    CABasicAnimation *bAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    CABasicAnimation *cAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // fromValue不赋值默认就是自己本身属性的值
    // bAnimation.fromValue = [NSValue valueWithCGRect:_testView.bounds];
    bAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    
    // cAnimation.fromValue = [NSNumber numberWithFloat:_testView.layer.cornerRadius];
    cAnimation.toValue = [NSNumber numberWithFloat:100 / 2];
    group.duration = 5;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [group setAnimations:@[bAnimation,cAnimation]];
    group.removedOnCompletion = NO;
    [_testView.layer addAnimation:group forKey:nil];
}


- (void)btnAction:(UIButton*)btn {
    NSInteger tag = btn.tag - 200;
    switch (tag) {
        case 0:
            [self animate0];
            break;
        case 1:
            [self animate1];
            break;
        case 2:
            [self animate2];
            break;
        default:
            break;
    }
}

@end

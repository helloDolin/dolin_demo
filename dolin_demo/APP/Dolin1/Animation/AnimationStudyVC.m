//
//  AnimationStudyVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/22.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationStudyVC.h"
#import "MMPlaceHolder.h"

static const CGFloat kBottomViewHeight = 100.0; // 底部view高度

/**
 🦍🦍🦍
 CABasicAnimation、CAKeyframeAnimation 均继承自 CAPropertyAnimation
 CAPropertyAnimation 继承自 CAAnimation
 CAAnimationGroup 继承自 CAAnimation
 */
@interface AnimationStudyVC ()
{
    UIView* _testView;
}
@end

@implementation AnimationStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
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
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kBottomViewHeight);
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
        make.size.equalTo(@[btn2,btn3]);
    }];

    // 等间距设置
    [@[btn1,btn2,btn3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:10];
    
    [btn1 showPlaceHolder];
}


/**
 基本动画
 均已锚点为准做动画
 */
- (void)animate0 {
    CABasicAnimation* basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, NAVIGATION_BAR_HEIGHT)]; // 动画起始位置
    basicAni.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - kBottomViewHeight)]; // 动画结束位置
    basicAni.duration = 2; // 动画时长
    basicAni.autoreverses = YES; // 为YES时，动画结束时，动画返回到初始位置
    basicAni.removedOnCompletion = NO; // 动画结束后不会回到开始的值，保持动画结束后的形态，layer相关属性值没变
    basicAni.fillMode = kCAFillModeForwards; // 当动画结束后，layer会一直保持着动画最后的状态
    [_testView.layer addAnimation:basicAni forKey:nil];
}

/**
 关键帧动画
 */
- (void)animate1 {
    CAKeyframeAnimation *frameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue* value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    NSValue* value2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    NSValue* value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    //贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:60 startAngle:M_PI endAngle:M_PI_2 clockwise:true];
    // 设置贝塞尔曲线路径
    frameAni.path = circlePath.CGPath;
    
//    frameAni.values = @[value1,value2,value3];
    frameAni.duration = 2;
    frameAni.removedOnCompletion = NO;
    frameAni.fillMode = kCAFillModeForwards;
    [_testView.layer addAnimation:frameAni forKey:nil];
}

/**
 组合动画
 */
- (void)animate2 {
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // fromValue不赋值默认就是自己本身属性的值
    // bAnimation.fromValue = [NSValue valueWithCGRect:_testView.bounds];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    
    // cAnimation.fromValue = [NSNumber numberWithFloat:_testView.layer.cornerRadius];
    radiusAnimation.toValue = [NSNumber numberWithFloat:100 / 2];
    group.duration = 5;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [group setAnimations:@[boundsAnimation,radiusAnimation]];
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

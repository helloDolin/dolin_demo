//
//  LoadingBtn.m
//  dolin_demo
//
//  Created by dolin on 17/1/12.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LoadingBtn.h"

@interface LoadingBtn()

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) CAShapeLayer *leftShape;
@property (nonatomic,copy) CallBack clickBlock;
@property (nonatomic,copy) CallBack callback;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,assign) CGRect deframe;
@property (nonatomic,assign) CGFloat cornerRadius;

@end

@implementation LoadingBtn

+ (instancetype)LoadingBtnInitWithFrame:(CGRect)frame
                     andBackgroundColor:(UIColor *)backgroundColor
                               andTitle:(NSString *)title
                          andTitleColor:(UIColor *)titleColor
                           andTitleFont:(UIFont *)titleFont
                        andCornerRadius:(CGFloat)cornerRadius
                          andClickBlock:(CallBack)clickBlock {
    LoadingBtn* btn = [[LoadingBtn alloc]initWithFrame:frame];
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = backgroundColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn addTarget:btn action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    btn.deframe = frame;
    btn.titleColor = titleColor;
    btn.cornerRadius = cornerRadius;
    btn.clickBlock = clickBlock;
    
    return btn;
}

- (void)btnAction {
    // 禁用用户交互
    self.userInteractionEnabled = NO;
    // 隐藏title
    [self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    // 执行代码块
    self.clickBlock();
    // 开始动画
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        // 将矩形按钮缩成圆型
        self.layer.cornerRadius = self.height / 2.0;
        self.layer.masksToBounds = YES;
        // 改变frame
        self.frame = CGRectMake((SCREEN_WIDTH - self.height) / 2.0, self.y, self.height, self.height);
    } completion:^(BOOL finished) {
        // 添加小弧线
        [self.layer addSublayer:self.leftShape];
        // 显示小弧线
        self.leftShape.hidden = NO;
        // 旋转圆形按钮
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = @(2 * M_PI);
        animation.repeatCount = HUGE_VAL;
        animation.duration = 1;
        animation.fillMode = kCAFillModeBoth;
        animation.removedOnCompletion = NO;
        [self.layer addAnimation:animation forKey:nil];
    }];
}

- (void)stopAnimateAndCallBack:(CallBack)callBack {
    // 移除旋转动画
    [self.layer removeAllAnimations];
    // 隐藏小弧线
    self.leftShape.hidden = YES;
    // 开始动画
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        // 将圆形按钮展开成矩形
        // 恢复最初圆角
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
        // 恢复最初frame
        self.frame = self.deframe;
        // 显示title
        [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        // 开启用户交互
        self.userInteractionEnabled = YES;
        // 执行代码块
        callBack();
    }];
}

// 白色小弧线
- (CAShapeLayer *)leftShape {
    if (!_leftShape) {
        _leftShape = [[CAShapeLayer alloc]init];
        CGFloat radius = self.height / 2.0;
        // startAngle endAngle 位置 参考官方文档
        CGFloat startAngle = M_PI + M_PI_2;
        CGFloat endAngle =  startAngle + M_PI / 4;
        UIBezierPath *leftPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - 5 startAngle:startAngle endAngle:endAngle clockwise:YES];
        leftPath.lineWidth = 3;
        
        _leftShape.path = leftPath.CGPath;
        _leftShape.fillColor = [UIColor clearColor].CGColor;
        _leftShape.strokeColor = [UIColor whiteColor].CGColor;
        _leftShape.lineWidth = leftPath.lineWidth;
        
//        _leftShape.strokeStart = 0.0f;
//        _leftShape.strokeEnd = 0.5f;
    }
    return _leftShape;
}

@end

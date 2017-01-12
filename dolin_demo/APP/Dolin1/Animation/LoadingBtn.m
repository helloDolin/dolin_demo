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
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = titleFont;
    
    // nice
    [btn addTarget:btn action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    btn.deframe = frame;
    btn.titleColor = titleColor;
    btn.cornerRadius = cornerRadius;
    btn.clickBlock = clickBlock;
    
    return btn;
}

- (void)btnAction {
    //禁用用户交互
    self.userInteractionEnabled = NO;
    //隐藏title
    [self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    //执行代码块
    self.clickBlock();
    
    //开始动画
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        //1.将矩形按钮缩成圆型
        //改变圆角
        self.layer.cornerRadius = self.deframe.size.height / 2.0;
        self.layer.masksToBounds = YES;
        //改变frame
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.frame.size.height) / 2.0, self.frame.origin.y, self.frame.size.height, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        //添加小弧线
        [self.layer addSublayer:self.leftShape];
        //显示小弧线
        self.leftShape.hidden = NO;
        
        //2.旋转圆形按钮
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = @(M_PI * 7000);
        animation.duration = 1000;
        animation.beginTime = 0;
        animation.fillMode = kCAFillModeBoth;
        [self.layer addAnimation:animation forKey:nil];
    }];
}

- (void)stopAnimateAndCallBack:(CallBack)callBack {
    //移除旋转动画
    [self.layer removeAllAnimations];
    //隐藏小弧线
    self.leftShape.hidden = YES;
    
    //开始动画
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        //3.将圆形按钮展开成矩形
        //恢复最初圆角
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
        //恢复最初frame
        self.frame = self.deframe;
        //显示title
        [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        //开启用户交互
        self.userInteractionEnabled = YES;
        //执行代码块
        callBack();
    }];
}

//白色小弧线
- (CAShapeLayer *)leftShape {
    if (!_leftShape) {
        
        _leftShape = [[CAShapeLayer alloc]init];
        CGFloat radius = self.deframe.size.height / 2.0;
        UIBezierPath *leftPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - 5 startAngle:M_PI_2 + M_PI_4 endAngle:-M_PI clockwise:YES];
        leftPath.lineWidth = 3;
        _leftShape.path = leftPath.CGPath;
        _leftShape.backgroundColor = [UIColor clearColor].CGColor;
        _leftShape.fillColor = [UIColor clearColor].CGColor;
        _leftShape.lineCap = kCALineCapRound;
        _leftShape.lineJoin = kCALineJoinRound;
        _leftShape.strokeColor = [UIColor whiteColor].CGColor;
        _leftShape.lineWidth = leftPath.lineWidth;
    }
    return _leftShape;
}


@end

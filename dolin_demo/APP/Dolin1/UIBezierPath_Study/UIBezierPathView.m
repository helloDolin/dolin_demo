//
//  UIBezierPathView.m
//  dolin_demo
//
//  Created by dolin on 17/1/16.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "UIBezierPathView.h"

// 由弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)

// 由角度获取弧度
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

@implementation UIBezierPathView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIColor *brushColor = [UIColor whiteColor];
    
    // 根据一个Rect 画一个矩形曲线
    UIBezierPath *rectangular = [UIBezierPath bezierPathWithRect:CGRectMake(5, 5, 30, 30)];
    [RANDOM_UICOLOR set];
    [rectangular fill];
    [brushColor set];
    [rectangular stroke];
    
    // 根据一个Rect 画一个椭圆曲线  Rect为正方形时 画的是一个圆
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(40, 5, 50, 30)];
    [RANDOM_UICOLOR set];
    [oval fill];
    [brushColor set];
    [oval stroke];
    
    // 根据一个Rect 画一个圆角矩形曲线 (Radius:圆角半径)    当Rect为正方形时且Radius等于边长一半时 画的是一个圆
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(95, 5, 40, 30) cornerRadius:5];
    [RANDOM_UICOLOR set];
    [roundedRect fill];
    [brushColor set];
    [roundedRect stroke];
    
    // 根据一个Rect 针对四角中的某个或多个角设置圆角
    UIBezierPath *roundedRect2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(140, 5, 40, 30) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 50)];
    [RANDOM_UICOLOR set];
    [roundedRect2 fill];
    [brushColor set];
    [roundedRect2 stroke];
    
    // 以某个中心点画弧线
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 15) radius:20 startAngle:0 endAngle:degreesToRadian(90) clockwise:YES];
    [brushColor set];
    [arcPath stroke];
    
    // 添加一个弧线
    UIBezierPath *arcPath2 = [UIBezierPath bezierPath];
    [arcPath2 moveToPoint:CGPointMake(230, 30)];
    [arcPath2 addArcWithCenter:CGPointMake(265, 30) radius:25 startAngle:degreesToRadian(180) endAngle:degreesToRadian(360) clockwise:YES];
    // 添加一个UIBezierPath
    [arcPath2 appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(265, 30) radius:20 startAngle:0 endAngle:M_PI*2 clockwise:YES]];
    [RANDOM_UICOLOR set];
    [arcPath2 stroke];
    
    // 根据CGPath创建并返回一个新的UIBezierPath对象
//    UIBezierPath *be = [self bezierPathWithCGPath];
//    [RANDOM_UICOLOR set];
//    [be stroke];
    
    // 三角形
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:CGPointMake(145, 165)];
    [triangle addLineToPoint:CGPointMake(155, 185)];
    [triangle addLineToPoint:CGPointMake(135, 185)];
    [RANDOM_UICOLOR set];
    [triangle fill];
    //    [triangle stroke];
    [triangle closePath];
    
    // 二次贝塞尔曲线
    UIBezierPath *quadBe = [UIBezierPath bezierPath];
    [quadBe moveToPoint:CGPointMake(30, 150)];
    [quadBe addQuadCurveToPoint:CGPointMake(130, 150) controlPoint:CGPointMake(30, 70)];
    
    UIBezierPath *quadBe2 = [UIBezierPath bezierPath];
    [quadBe2 moveToPoint:CGPointMake(160, 150)];
    [quadBe2 addQuadCurveToPoint:CGPointMake(260, 150) controlPoint:CGPointMake(210, 50)];
    [quadBe2 appendPath:quadBe];
    quadBe2.lineWidth = 1.5f;
    quadBe2.lineCapStyle = kCGLineCapSquare;
    quadBe2.lineJoinStyle = kCGLineJoinRound;
    [brushColor set];
    [quadBe2 stroke];
    
    // 三次贝塞尔曲线
    UIBezierPath *threePath = [UIBezierPath bezierPath];
    [threePath moveToPoint:CGPointMake(30, 250)];
    [threePath addCurveToPoint:CGPointMake(260, 230) controlPoint1:CGPointMake(120, 180) controlPoint2:CGPointMake(150, 260)];
    threePath.lineWidth = 1.5f;
    threePath.lineCapStyle = kCGLineCapSquare;
    threePath.lineJoinStyle = kCGLineJoinRound;
    [brushColor set];
    [threePath stroke];
}

- (UIBezierPath *)bezierPathWithCGPath {
    UIBezierPath *framePath;
    CGFloat arrowWidth = 14;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rectangle = CGRectInset(CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds)), 3,3);
    
    CGPoint p[3] = {
        
        {CGRectGetMidX(self.bounds)-arrowWidth/2, CGRectGetWidth(self.bounds)-6},
        
        {CGRectGetMidX(self.bounds)+arrowWidth/2, CGRectGetWidth(self.bounds)-6},
        
        {CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds)-4}
        
    };
    
    CGPathAddRoundedRect(path, NULL, rectangle, 5, 5);
    
    CGPathAddLines(path, NULL, p, 3);
    
    CGPathCloseSubpath(path);
    // 根据CGPath创建并返回一个新的UIBezierPath对象
    framePath = [UIBezierPath bezierPathWithCGPath:path];
    
    CGPathRelease(path);
    
    return framePath;
}

@end

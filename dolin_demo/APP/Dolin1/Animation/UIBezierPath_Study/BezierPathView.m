//
//  BezierPathView.m
//  dolin_demo
//
//  Created by dolin on 16/9/23.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "BezierPathView.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian * 180.0) / (M_PI)

@implementation BezierPathView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    switch (self.type) {
        case kDefaultPath: {
            [self drawTrianglePath];
            break;
        }
        case kRectPath: {
            [self drawRectPath];
            break;
        }
        case kCirclePath: {
            [self drawCiclePath];
            break;
        }
        case kOvalPath: {
            [self drawOvalPath];
            break;
        }
        case kRoundedRectPath: {
            [self drawRoundedRectPath];
            break;
        }
        case kArcPath: {
            [self drawArcPath];
            break;
        }
        case kSecondBezierPath: {
            [self drawSecondBezierPath];
            break;
        }
        case kThirdBezierPath: {
            [self drawThirdBezierPath];
            break;
        }
    }
}

// 画三角形
- (void)drawTrianglePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.width - 40, 20)];
    [path addLineToPoint:CGPointMake(self.width / 2, self.height - 20)];
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //  [path addLineToPoint:CGPointMake(20, 20)];
    [path closePath];
    
    path.lineWidth = 1.5;
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    // 将后续笔触和填充操作的颜色设置为接收器表示的颜色（摘自官方文档）
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

// 画矩形
- (void)drawRectPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, self.width - 40, self.height - 40)];
    
    path.lineWidth = 1.5;
    // 结尾处的样式
    //    1、kCGLineCapButt
    //    该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
    //    2、kCGLineCapRound
    //    该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
    //    3、kCGLineCapSquare
    //    该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
    path.lineCapStyle = kCGLineCapRound;
    // 设置两条线连结点的样式
    //    1、kCGLineJoinMiter
    //    斜接
    //    2、kCGLineJoinRound
    //    圆滑衔接
    //    3、kCGLineJoinBevel
    //    斜角连接
    path.lineJoinStyle = kCGLineJoinRound;
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

// 画圆
- (void)drawCiclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.width - 40, self.width - 40)];
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

// 画椭圆
- (void)drawOvalPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.width - 40, self.height - 40)];
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

- (void)drawRoundedRectPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, self.width - 40, self.height - 40) byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 20)];
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

- (void)drawArcPath {
    CGPoint center = CGPointMake(self.width / 2, self.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:100
                                                    startAngle:0
                                                      endAngle:degreesToRadian(90)
                                                     clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    UIColor *strokeColor = RANDOM_UICOLOR;
    [strokeColor set];
    [path stroke];
}

- (void)drawSecondBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起始端点
    [path moveToPoint:CGPointMake(20, self.height - 100)];
    // 添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - 20, self.frame.size.height - 100)
                 controlPoint:CGPointMake(self.frame.size.width / 2, 0)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
}

- (void)drawThirdBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起始端点
    [path moveToPoint:CGPointMake(20, 150)];
    // 添加三次路径
    [path addCurveToPoint:CGPointMake(300, 150)
            controlPoint1:CGPointMake(160, 0)
            controlPoint2:CGPointMake(160, 250)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
}

@end

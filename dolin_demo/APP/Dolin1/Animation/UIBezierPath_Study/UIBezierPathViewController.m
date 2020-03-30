//
//  UIBezierPathViewController.m
//  dolin_demo
//
//  Created by dolin on 16/9/23.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "UIBezierPathViewController.h"
#import "BezierPathView.h"

@interface UIBezierPathViewController ()

@property (nonatomic, strong) CAShapeLayer  *circleLayer;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) NSArray       *animationTypes;
@property (nonatomic, assign) NSUInteger    index;
@property (nonatomic, strong) BezierPathView *pathView;

@end

@implementation UIBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testBezierPath];
    // 使用CAShapeLayer与UIBezierPath画圆
    [self.view.layer addSublayer:self.circleLayer];
}

- (CAShapeLayer *)circleLayer {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0, 0, 100, 100);
    circleLayer.position = CGPointMake(SCREEN_WIDTH / 2, NAVIGATION_BAR_HEIGHT + 50);
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 2.0;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 使用UIBezierPath创建路径
    CGRect frame = CGRectMake(0, 0, 100, 100);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    circleLayer.path = circlePath.CGPath;
    // 从 0 / 2π 的位置开始
    circleLayer.strokeStart = 0.0;
    circleLayer.strokeEnd = 0.85;
    return circleLayer;
}

- (void)testBezierPath {
    BezierPathView *bezierPathView = [[BezierPathView alloc] initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT + 100, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATION_BAR_HEIGHT - 100)];
    [self.view addSubview:bezierPathView];
    
    bezierPathView.layer.borderColor = RANDOM_UICOLOR.CGColor;
    bezierPathView.layer.borderWidth = 5;
    bezierPathView.backgroundColor = [UIColor whiteColor];
    
    bezierPathView.type = kDefaultPath;
    self.index = 0;
    
    self.animationTypes = @[@(kDefaultPath),
                            @(kRectPath),
                            @(kCirclePath),
                            @(kOvalPath),
                            @(kRoundedRectPath),
                            @(kArcPath),
                            @(kSecondBezierPath),
                            @(kThirdBezierPath)
                            ];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector(updateType)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor blueColor].CGColor;
    self.pathView = bezierPathView;
}

- (void)updateType {
    if (self.index + 1 < self.animationTypes.count) {
        self.index ++;
    } else {
        self.index = 0;
    }
    
    self.pathView.type = [[self.animationTypes objectAtIndex:self.index] intValue];
    [self.pathView setNeedsDisplay];
}

@end

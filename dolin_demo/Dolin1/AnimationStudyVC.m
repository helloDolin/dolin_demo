//
//  AnimationStudyVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/22.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationStudyVC.h"

@interface AnimationStudyVC ()
{
    UIView* _testView;
}
@end

@implementation AnimationStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _testView.backgroundColor = RANDOM_UICOLOR;
    
    UIButton* btn;
    for (int i = 0 ; i < 5; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = RANDOM_UICOLOR;
        btn.titleLabel.textColor = [UIColor whiteColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        btn.tag = i + 200;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWidth = SCREEN_WIDTH / 5;
        float btnHeight = btnWidth / 2;
        btn.frame = CGRectMake(btnWidth * i, SCREEN_HEIGHT - 64 - btnHeight , btnWidth, btnHeight);
        [self.view addSubview:btn];
    }
    
    [self.view addSubview:_testView];
}

- (void)animate0 {
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"position"];
    ba.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    ba.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    ba.duration = 2;
    
    ba.autoreverses = YES; // 动画结束后是否自动回到原来位置；
    ba.removedOnCompletion = NO; //动画结束后是否移除
    
    //fillMode：动画结束后的显示模式；
    //kCAFillModeForwards 保留动画结束后的位置；
    //kCAFillModeBackwards：回到动画最开始的位置。
    //注意；使用fillMode的时候必须要将removedOnCompletion致为NO
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
    CATransition* transition = [CATransition animation];
    transition.duration = 2;
    
    // timingFunction：一个过渡时间的函数，有线性，先快后慢，先慢后快等等；
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    
    // type ：动画类型
    // kCATransitionFade：交叉淡化过渡
    // kCATransitionMoveIn：移动覆盖原图；
    // kCATransitionPush：新视图将旧视图推出去；
    // kCATransitionReveal：底部显出来。
    transition.type = kCATransitionPush;
    
    // 子类型。其中的枚举类型看到英文就知道是什么意思了。
    transition.subtype = kCATransitionFromBottom;
    
    //CATransition不是CAAnimation的子类，所以没有animationWithKeyPath:这个构造方法，只有CAPropertyAnimation的子类才有这个构造方法！
    [_testView.layer addAnimation:transition forKey:nil];
}

- (void)animate3 {
    // group animation
}

- (void)animate4 {
    
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
        case 3:
            [self animate3];
            break;
        case 4:
            [self animate4];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

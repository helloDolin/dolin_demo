//
//  OriginAPIAnimateStudyVC.m
//  dolin_demo
//
//  Created by dolin on 16/12/14.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "OriginAPIAnimateStudyVC.h"

@interface OriginAPIAnimateStudyVC ()

@property (nonatomic, strong) UIImageView *view1;
@property (nonatomic, strong) UIImageView *view2;
@property (nonatomic, strong) UIImageView *view3;

@end

@implementation OriginAPIAnimateStudyVC

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self setLeftBarBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method
// setLeftBarBtnItem
- (void)setLeftBarBtn {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"edit", nil) style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)leftItemAction {
//    [self test1];
    [self test2];
}

- (void)test3 {
    CGPoint originCenter = self.view1.center;
    /**
     *  为当前视图设置基于关键帧的动画
     *  在动画块中，您必须通过调用addKeyframeWithRelativeStartTime：relativeDuration：animations：方法一次或多次来添加关键帧时间和动画数据
     *  添加关键帧会导致动画将视图从当前值动画化为第一个关键帧的值，然后到下一个关键帧的值，依此类推，直到您指定的时间为止。
     *  参数：duration 如果指定负值或0，则立即进行更改，而不使用动画。
     */
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            self.view1.centerX += 80.0;
            self.view1.centerY -= 10.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            self.view1.transform = CGAffineTransformMakeRotation(-M_PI_4/2);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            self.view1.centerX += 100.0;
            self.view1.centerY -= 50.0;
            self.view1.alpha = 0.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            self.view1.transform = CGAffineTransformIdentity;
            self.view1.center = CGPointMake(0, originCenter.y);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.view1.alpha = 1.0;
            self.view1.center = originCenter;
        }];
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)test2 {
    /**
     *  为指定的容器视图创建一个过渡动画。
     */
    [UIView transitionWithView:self.view1 duration:1 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionCurlDown  animations:^{
        
    } completion:^(BOOL finished) {
        self.view1.backgroundColor = RANDOM_UICOLOR;
    }];
}

- (void)test1 {
    
    self.view2.alpha = 0;
    self.view3.alpha = 0;
    
    
//    引用：Spring Animation 是线性动画或 ease-out 动画的理想替代品。由于 iOS 本身大量使用的就是 Spring Animation，用户已经习惯了这种动画效果，因此使用它能使   App 让人感觉更加自然，用 Apple 的话说就是「instantly familiar」。此外，Spring Animation 不只能对位置使用，它适用于所有可被添加动画效果的属性。
    
    /**
     使用与物理弹簧的运动相对应的定时曲线执行视图动画
     damp:振幅，弹簧振幅 0-1取值：数值越小「弹簧」的振动效果越明显
     Velocity:速率 为了顺利开始动画，请将此值与视图的速度（与附件前相同）进行匹配。
     
    */
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionRepeat animations:^{
        self.view1.centerY += 100;
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionRepeat animations:^{
        self.view2.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionRepeat animations:^{
        self.view3.alpha = 1;
        self.view3.centerY -= 100;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutUI {
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    
    CGFloat padding = (SCREEN_HEIGHT - 64 - 300) / 4;
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@100);
        make.top.equalTo(self.view).offset(padding + 64);
    }];
    
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@100);
        make.top.equalTo(_view1.mas_bottom).offset(padding);
    }];
    
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@100);
        make.top.equalTo(_view2.mas_bottom).offset(padding);
    }];

}
#pragma mark - event

#pragma mark - UITableViewDelegate && UITableViewDataSource

#pragma mark - getter && setter
- (UIImageView*)view1 {
    if (!_view1) {
        _view1 = [[UIImageView alloc]init];
        _view1.backgroundColor = RANDOM_UICOLOR;
    }
    return _view1;
}

- (UIImageView*)view2 {
    if (!_view2) {
        _view2 = [[UIImageView alloc]init];
        _view2.backgroundColor = RANDOM_UICOLOR;

    }
    return _view2;
}

- (UIImageView*)view3 {
    if (!_view3) {
        _view3 = [[UIImageView alloc]init];
        _view3.backgroundColor = RANDOM_UICOLOR;
    }
    return _view3;
}
#pragma mark - API

#pragma mark - override

@end

//
//  CABasicAnimationStudyVC.m
//  dolin_demo
//
//  Created by dolin on 2017/6/28.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "CABasicAnimationStudyVC.h"

@interface CABasicAnimationStudyVC ()
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation CABasicAnimationStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.testView];
    [self.view addSubview:self.btn];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//属性	说明
//duration	动画的时长
//repeatCount	重复的次数。不停重复设置为 HUGE_VALF
//repeatDuration	设置动画的时间。在该时间内动画一直执行，不计次数。
//beginTime	指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
//timingFunction	设置动画的速度变化
//autoreverses	动画结束时是否执行逆动画
//fromValue	所改变属性的起始值
//toValue	所改变属性的结束时的值
//byValue	所改变属性相同起始值的改变量

- (void)btnAction {
    // 大小改变设置
    CABasicAnimation *bAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    // 按钮圆角数设置
    CABasicAnimation *cAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    // 组合动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 大小改变设置
    bAnimation.fromValue = [NSValue valueWithCGRect:_testView.bounds];
    bAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    
    // 按钮圆角数设置
    cAnimation.fromValue = [NSNumber numberWithFloat:_testView.layer.cornerRadius];
    cAnimation.toValue = [NSNumber numberWithFloat:100 / 2];
    
    // 组合动画设置
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [group setAnimations:@[bAnimation,cAnimation]];
    group.duration = 5;
//    在动画执行完成之后，最好还是将动画移除掉。也就是尽量不要设置removedOnCompletion属性为NO
//    group.removedOnCompletion = YES;
    
    // 防止动画结束后回到初始状态
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [_testView.layer addAnimation:group forKey:nil];
    
}

- (UIView*)testView {
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        _testView.center = self.view.center;
        _testView.backgroundColor = RANDOM_UICOLOR;
    }
    return _testView;
}

- (UIButton*)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = RANDOM_UICOLOR;
        [_btn setTitle:@"test" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

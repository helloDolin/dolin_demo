//
//  LottieStudyVC.m
//  dolin_demo
//
//  Created by shaolin on 2017/11/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LottieStudyVC.h"
#import <Lottie/Lottie.h>

const float kBtnHeight = 50;

@interface LottieStudyVC ()
{
    NSArray* _arr;
    int _index;
}
@property (nonatomic, strong) LOTAnimationView *diantouAnimation;
@property (nonatomic, strong) LOTAnimationView *thinkAnimation;
@property (nonatomic, strong) LOTAnimationView *zhayanAnimation;
@property (nonatomic, strong) LOTAnimationView *ciclista_salitaAnimation;

@end

@implementation LottieStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, kBtnHeight);
    btn.backgroundColor = RANDOM_UICOLOR;
    [btn setTitle:@"click me！！！" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // init
    _arr = @[self.diantouAnimation,self.thinkAnimation,self.zhayanAnimation,self.ciclista_salitaAnimation];
    _index = 0;
    
}

- (void)btnAction {
    [_arr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    LOTAnimationView* show = _arr[_index];
    [self.view addSubview:show];
    [show play];
    _index++;
    if (_index == 4) {
        _index = 0;
    }
}

- (LOTAnimationView*)diantouAnimation {
    if (!_diantouAnimation) {
        _diantouAnimation = [LOTAnimationView animationNamed:@"diantou" inBundle:[NSBundle mainBundle]];
        _diantouAnimation.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + kBtnHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        _diantouAnimation.loopAnimation = YES;
    }
    return _diantouAnimation;
}

- (LOTAnimationView*)thinkAnimation {
    if (!_thinkAnimation) {
        _thinkAnimation = [LOTAnimationView animationNamed:@"think" inBundle:[NSBundle mainBundle]];
        _thinkAnimation.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + kBtnHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        _thinkAnimation.loopAnimation = YES;
    }
    return _thinkAnimation;
}

- (LOTAnimationView*)zhayanAnimation {
    if (!_zhayanAnimation) {
        _zhayanAnimation = [LOTAnimationView animationNamed:@"zhayan" inBundle:[NSBundle mainBundle]];
        _zhayanAnimation.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + kBtnHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        _zhayanAnimation.loopAnimation = YES;
    }
    return _zhayanAnimation;
}

- (LOTAnimationView*)ciclista_salitaAnimation {
    if (!_ciclista_salitaAnimation) {
        _ciclista_salitaAnimation = [LOTAnimationView animationNamed:@"ciclista_salita" inBundle:[NSBundle mainBundle]];
        _ciclista_salitaAnimation.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + kBtnHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        _ciclista_salitaAnimation.loopAnimation = YES;
        _ciclista_salitaAnimation.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _ciclista_salitaAnimation;
}

@end

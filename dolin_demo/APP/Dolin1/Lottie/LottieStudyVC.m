//
//  LottieStudyVC.m
//  dolin_demo
//
//  Created by shaolin on 2017/11/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LottieStudyVC.h"
#import <Lottie/Lottie.h>

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
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, SCREEN_WIDTH, 50);
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
        _diantouAnimation.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _diantouAnimation.loopAnimation = YES;
    }
    return _diantouAnimation;
}

- (LOTAnimationView*)thinkAnimation {
    if (!_thinkAnimation) {
        _thinkAnimation = [LOTAnimationView animationNamed:@"think" inBundle:[NSBundle mainBundle]];
        _thinkAnimation.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _thinkAnimation.loopAnimation = YES;
    }
    return _thinkAnimation;
}

- (LOTAnimationView*)zhayanAnimation {
    if (!_zhayanAnimation) {
        _zhayanAnimation = [LOTAnimationView animationNamed:@"zhayan" inBundle:[NSBundle mainBundle]];
        _zhayanAnimation.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _zhayanAnimation.loopAnimation = YES;
    }
    return _zhayanAnimation;
}

- (LOTAnimationView*)ciclista_salitaAnimation {
    if (!_ciclista_salitaAnimation) {
        _ciclista_salitaAnimation = [LOTAnimationView animationNamed:@"ciclista_salita" inBundle:[NSBundle mainBundle]];
        _ciclista_salitaAnimation.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _ciclista_salitaAnimation.loopAnimation = YES;
    }
    return _ciclista_salitaAnimation;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

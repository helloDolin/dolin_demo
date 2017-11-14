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

@end

@implementation LottieStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //从本地指定的bundle的json加载
    LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"ciclista_salita" inBundle:[NSBundle mainBundle]];
    animationView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 300);
    animationView.loopAnimation = YES;
    [self.view addSubview:animationView];
    [animationView play];
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

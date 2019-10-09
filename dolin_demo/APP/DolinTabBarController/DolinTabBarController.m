//
//  DolinTabBarController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinTabBarController.h"

#import "Dolin1ViewController.h"
#import "Dolin2ViewController.h"
#import "Dolin3ViewController.h"
#import "Dolin4ViewController.h"

#import "UITabBar+Badge.h"
#import <AudioToolbox/AudioToolbox.h>


@interface DolinTabBarController ()

// 毛玻璃
@property(nonatomic,strong)UIBlurEffect *blureffect;
// 毛玻璃
@property(nonatomic,strong)UIVisualEffectView *visualeffectview;


@end

@implementation DolinTabBarController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    [self setupAllChildViewController];
    [self setupNavigationBar];
    [self.tabBar showBadgeOnItemIndex:3];  // 设置小红点
    [self setupTabBarItemFontColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method
- (void)setupTabBarItemFontColor {
    //设置字体颜色
    UIColor *titleNormalColor = [UIColor colorWithWhite:0.8 alpha:1];
    UIColor *titleSelectedColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNormalColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleSelectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
}

- (void)setupTabBar {
    self.tabBar.barStyle = UIBarStyleBlack;
}

// ps： 关于item的设置，这边可以直接用原生的item素材，选中和未选中状态
- (void)setupAllChildViewController{
    Dolin1ViewController *dolin1ViewController = [[Dolin1ViewController alloc]init];
    [self setupOneChildViewController:dolin1ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"discover", nil)];
    
    Dolin2ViewController *dolin2ViewController = [[Dolin2ViewController alloc]init];
    [self setupOneChildViewController:dolin2ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_music"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_music_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"music", nil)];
    
    Dolin3ViewController *dolin3ViewController = [[Dolin3ViewController alloc]init];
    [self setupOneChildViewController:dolin3ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_friend"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_friend_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"RN", nil)];
    
    Dolin4ViewController *dolin4ViewController = [[Dolin4ViewController alloc]init];
    [self setupOneChildViewController:dolin4ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_account"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_account_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"me", nil)];
    
}

- (void)setupOneChildViewController:(UIViewController *)viewController
                        normalImage:(UIImage*)normalImage
                      selectedImage:(UIImage*)selectedImage
                              title:(NSString *)title {
    viewController.title = title;
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.image = normalImage;
    navC.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:navC];
}

- (void)setupNavigationBar {
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // bar tint color
    bar.barTintColor = [UIColor colorWithRed:211/255.0f green:38/255.0f  blue:39/255.0f alpha:1.0f];
    // 设置字体颜色
    bar.tintColor = [UIColor whiteColor];
    // 设置title前景色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

/**
 *  获取原生图片
 *
 *  @param imageName 图片名
 *
 *  @return
 */
- (UIImage*)getOriginalImageByImageName:(NSString*)imageName {
    UIImage *originalImage = [UIImage imageNamed:imageName];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index]; // 点击时动画
    [self playSound]; // 点击时音效
}


- (void)playSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)animationWithIndex:(NSInteger)index {
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
//    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.08;
//    pulse.repeatCount = 1;
//    pulse.autoreverses = YES;
//    pulse.fromValue = [NSNumber numberWithFloat:0.7];
//    pulse.toValue = [NSNumber numberWithFloat:1.3];
//    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

@end

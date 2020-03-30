//
//  DolinTabBarController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinTabBarController.h"

#import "Dolin1VC.h"
#import "Dolin2VC.h"
#import "Dolin3VC.h"
#import "Dolin4VC.h"

#import "UITabBar+Badge.h"

@interface DolinTabBarController ()

@end

@implementation DolinTabBarController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    [self setupAllChildViewController];
    [self setupNavigationBar];
    [self setupTabBarItemFontColor];
    [self.tabBar showBadgeOnItemIndex:3];  // 设置小红点
}

#pragma mark -  method
- (void)setupTabBarItemFontColor {
    //设置字体颜色
    UIColor *titleNormalColor = [UIColor colorWithWhite:0.8 alpha:1];
    UIColor *titleSelectedColor = [UIColor whiteColor];

    self.tabBar.tintColor = [UIColor whiteColor];

    
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

// ps：关于item的设置，这边可以直接用原生的 item 素材，选中和未选中状态
- (void)setupAllChildViewController{
    Dolin1VC *dolin1VC = [[Dolin1VC alloc]init];
    [self setupOneChildViewController:dolin1VC normalImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"Index", nil)];
    
    Dolin2VC *dolin2VC = [[Dolin2VC alloc]init];
    [self setupOneChildViewController:dolin2VC normalImage:[[UIImage imageNamed:@"cm2_btm_icn_music"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_music_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"Music", nil)];
    
    Dolin3VC *dolin3VC = [[Dolin3VC alloc]init];
    [self setupOneChildViewController:dolin3VC normalImage:[[UIImage imageNamed:@"cm2_btm_icn_friend"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_friend_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"Flutter", nil)];
    
    Dolin4VC *dolin4VC = [[Dolin4VC alloc]init];
    [self setupOneChildViewController:dolin4VC normalImage:[[UIImage imageNamed:@"cm2_btm_icn_account"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_account_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"Me", nil)];
    
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

- (UIImage*)getOriginalImageByImageName:(NSString*)imageName {
    UIImage *originalImage = [UIImage imageNamed:imageName];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

- (void)playSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray * tabbarBtnArr = [NSMutableArray array];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarBtnArr addObject:tabBarButton];
        }
    }
    
    // scale 模拟跳动动画
    CABasicAnimation* pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    UIView *view = tabbarBtnArr[index];
    [view.layer addAnimation:pulse forKey:nil];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    [self animationWithIndex:index];
//    [self playSound];
}

@end

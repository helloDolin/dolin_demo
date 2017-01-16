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


@interface DolinTabBarController ()

//毛玻璃
@property(nonatomic,strong)UIBlurEffect *blureffect;
//毛玻璃
@property(nonatomic,strong)UIVisualEffectView *visualeffectview;

// 记录点击那个item
@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation DolinTabBarController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    [self setUpAllChildViewController];
    [self setUpNavigationBar];
    [self.tabBar showBadgeOnItemIndex:3];  // 设置小红点
    [self setUpTabBarItemFontColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method

- (void)setUpTabBarItemFontColor {
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
//    self.tabBar.barStyle = UIBarStyleBlack;
//    self.tabBar.translucent = NO;
    
    //tabbar背景色
    //毛玻璃
    self.blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //添加毛玻璃view视图
    self.visualeffectview = [[UIVisualEffectView alloc]initWithEffect:self.blureffect];
    //设置毛玻璃的view视图的大小
    self.visualeffectview.frame = self.tabBar.bounds;
    //设施模糊的透明度
    self.visualeffectview.alpha = 1;
    
    self.tabBar.backgroundImage =[[UIImage alloc]init];
    [self.tabBar insertSubview:self.visualeffectview atIndex:0];
    self.tabBar.opaque = YES;
}

// ps： 关于item的设置，这边可以直接用原生的item素材，选中和未选中状态
- (void)setUpAllChildViewController{
    Dolin1ViewController *dolin1ViewController = [[Dolin1ViewController alloc]init];
    [self setUpOneChildViewController:dolin1ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_discovery_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"discover", nil)];
    
    Dolin2ViewController *dolin2ViewController = [[Dolin2ViewController alloc]init];
    [self setUpOneChildViewController:dolin2ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_music"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_music_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"music", nil)];
    
    Dolin3ViewController *dolin3ViewController = [[Dolin3ViewController alloc]init];
    [self setUpOneChildViewController:dolin3ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_friend"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_friend_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"friend", nil)];
    
    Dolin4ViewController *dolin4ViewController = [[Dolin4ViewController alloc]init];
    [self setUpOneChildViewController:dolin4ViewController normalImage:[[UIImage imageNamed:@"cm2_btm_icn_account"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cm2_btm_icn_account_prs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:NSLocalizedString(@"me", nil)];
    
}

- (void)setUpOneChildViewController:(UIViewController *)viewController
                        normalImage:(UIImage*)normalImage
                      selectedImage:(UIImage*)selectedImage
                              title:(NSString *)title {
    
    viewController.title = title;
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.tabBarItem.image = normalImage;
    navC.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:navC];
}

- (void)setUpNavigationBar {
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // bar tint color
    bar.barTintColor = [UIColor colorWithRed:211/255.0f green:38/255.0f  blue:39/255.0f alpha:1.0f];
    // [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.9];
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
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }

}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    
    self.indexFlag = index;
    
}

@end

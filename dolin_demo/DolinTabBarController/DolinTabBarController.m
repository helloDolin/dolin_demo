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

@end

@implementation DolinTabBarController

#pragma mark -  life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    [self setUpAllChildViewController];
    
    // 设置小红点
    [self.tabBar showBadgeOnItemIndex:3];
    
    [self setUpTabBarItemFontColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method

- (void)setUpTabBarItemFontColor {
    //设置字体颜色
    UIColor *titleNormalColor = [UIColor whiteColor];
    UIColor *titleSelectedColor = [UIColor orangeColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNormalColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleSelectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
}

- (void)setupTabBar {
    
    //    // 给tabbar 添加背景色
    //    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    //    bgView.backgroundColor = TAB_BAR_BG_COLOR;
    //    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.tabBar.translucent = NO;
    
    // ps： 关于item的设置，这边可以直接用原生的item素材，选中和未选中状态
}

- (void)setUpAllChildViewController{
    Dolin1ViewController *dolin1ViewController = [[Dolin1ViewController alloc]init];
    [self setUpOneChildViewController:dolin1ViewController normalImage:[[UIImage imageNamed:@"tab_bar_dolin1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_bar_dolin1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"dolin1"];
    
    Dolin2ViewController *dolin2ViewController = [[Dolin2ViewController alloc]init];
    [self setUpOneChildViewController:dolin2ViewController normalImage:[[UIImage imageNamed:@"tab_bar_dolin2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_bar_dolin2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"dolin2"];
    
    Dolin3ViewController *dolin3ViewController = [[Dolin3ViewController alloc]init];
    [self setUpOneChildViewController:dolin3ViewController normalImage:[[UIImage imageNamed:@"tab_bar_dolin3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_bar_dolin1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"dolin3"];
    
    Dolin4ViewController *dolin4ViewController = [[Dolin4ViewController alloc]init];
    [self setUpOneChildViewController:dolin4ViewController normalImage:[[UIImage imageNamed:@"tab_bar_dolin4"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_bar_dolin4"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] title:@"dolin4"];
    
}

- (void)setUpOneChildViewController:(UIViewController *)viewController
                        normalImage:(UIImage*)normalImage
                      selectedImage:(UIImage*)selectedImage
                              title:(NSString *)title {
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
    navC.tabBarItem.image = normalImage;
    navC.tabBarItem.selectedImage = selectedImage;
                                  
                                
    
    // 设置navigationBar
    // nav bar 主题设置
    navC.navigationBar.barStyle = UIBarStyleBlack;
    navC.navigationBar.translucent = NO;
    navC.navigationBar.tintColor = [UIColor whiteColor];
    
    [self addChildViewController:navC];
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

@end

//
//  DolinTabBarController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "DolinTabBarController.h"

#import "Dolin2VC.h"
#import "Dolin4VC.h"
#import "Dolin1VC.h"
#import "Dolin3VC.h"

#import "UITabBar+Badge.h"
#import "UIImage+ImageWithColor.h"

#import "DLTabBarBtn.h"

#define isIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kTabBarPadding (isIPhoneX?30:0)

/// 自定义 View，为了伸出去的 view 依然可以响应
@interface HLCustomView : UIView

@property (nonatomic, strong) UIButton *scanBtn;

@end

@implementation HLCustomView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint btnPoint = [self.scanBtn convertPoint:point fromView:self];
    if ([self.scanBtn pointInside:btnPoint withEvent:event]) {
        return self.scanBtn;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end

@interface DolinTabBarController ()

@property (nonatomic, strong) HLCustomView *tabBarView;
@property (nonatomic, strong) NSMutableArray<DLTabModel *> *tabarModelArray;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) DLTabModel *selectedTabModel;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *childVCArray;
@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation DolinTabBarController

static dispatch_once_t token;
static DolinTabBarController *instance = nil;

+ (instancetype)sharedInstance {
    dispatch_once(&token, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNavigationBar];
}

#pragma mark -  method
/// 设置状态栏为白色
- (void)setupStatusBar2Light {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

/// 设置状态栏为黑色
- (void)setupStatusBar2Dark {
    if (@available(iOS 13.0, *)){
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)setupUI {
    [self.view addSubview:self.tabBarView];
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50 + kTabBarPadding);
    }];
}

- (void)setupNavigationBar {
    // titleTextAttributes
    [UINavigationBar appearance].titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor blackColor] ,
        NSFontAttributeName: [UIFont systemFontOfSize:18]
    };

    // tintColor：设置字体颜色
    [UIApplication sharedApplication].delegate.window.tintColor = [UIColor blackColor];

    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        [appearance setBackIndicatorImage:[[UIImage imageNamed:@"left_arrow_grey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              transitionMaskImage:[UIImage imageNamed:@"back_arrow_mask_fixed"]];
        appearance.titleTextAttributes = @{
            NSFontAttributeName: [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName: [UIColor blackColor]
        };
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance = appearance;
    }
}

- (void)playSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - event
- (void)onTabClick:(DLTabBarBtn *)btn {
    [self switchTabarButton:btn];
    
    [self playSound];
    
    // scale 模拟跳动动画
    CABasicAnimation* pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    [btn.layer addAnimation:pulse forKey:nil];
}

#pragma mark - getter
- (HLCustomView *)tabBarView {
    if (!_tabBarView) {
        _tabBarView = [[HLCustomView alloc] init];
        _tabBarView.backgroundColor = [UIColor colorWithWhite:0.18 alpha:1];
        _tabBarView.layer.shadowOffset = CGSizeMake(0, -4);
        _tabBarView.layer.shadowOpacity = 0.06;
        _tabBarView.layer.shadowColor = UIColor.blackColor.CGColor;
        _tabBarView.layer.zPosition = 1000000;
    }
    return _tabBarView;
}

#pragma mark - setter
- (void)setTabarModelArray:(NSMutableArray<DLTabModel *> *)tabarModelArray {
    _tabarModelArray = tabarModelArray;
    [self setupViews:tabarModelArray];
}

- (void)setupViews:(NSArray <DLTabModel *> *)arr {
    [self.tabBarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat tabWidth = SCREEN_WIDTH / arr.count;
    UIButton *lastButton;
    NSMutableArray *btnMutableArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        DLTabModel *model = arr[i];
        DLTabBarBtn *button = [DLTabBarBtn buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.norTitle forState:UIControlStateNormal];
        [button setTitle:model.selTitle forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (model.norImageName.length > 0) {
            [button setImage:[UIImage imageNamed:model.norImageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:model.selImageName] forState:UIControlStateSelected];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.tag = 10000 + i;

        [btnMutableArr addObject:button];
        [self.tabBarView addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(tabWidth);
            make.height.equalTo(@50);

            if (IS_IPHONE_X) {
                 make.top.equalTo(self.tabBarView.mas_top).offset(10);
            } else {
                 make.top.equalTo(self.tabBarView.mas_top);
            }

            if (lastButton) {
                make.left.equalTo(lastButton.mas_right);
            } else {
                make.left.equalTo(self.tabBarView.mas_left);
                button.selected = YES;
            }
        }];

        CGSize imageSize = button.imageView.frame.size;
        CGSize titleSize = button.titleLabel.frame.size;
        CGSize textSize =  [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil].size;
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + 1);
        button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        button.titleEdgeInsets = UIEdgeInsetsMake(2, - imageSize.width, - (totalHeight - titleSize.height), 0);

        [button addTarget:self action:@selector(onTabClick:) forControlEvents:UIControlEventTouchUpInside];
        lastButton = button;
        if (!i) {
            self.selectedBtn = button;
            self.selectedTabModel = model;
        }
    }
    
    DLTabBarBtn *btn = [self.tabBarView viewWithTag:10000];
    [self switchTabarButton:btn];
    
    [self.tabBarView layoutIfNeeded];
}

- (void)switchTabarButton:(DLTabBarBtn *)btn {
    NSInteger index = btn.tag - 10000;
    [self changeTabBarWithIndex:index tabarButton:btn];
}

- (void)changeTabBarWithIndex:(NSInteger)index tabarButton:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    self.selectedTabModel = self.tabarModelArray[index];
    
    [self updateLocationWith:index];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)updateLocationWith:(NSInteger)index {
    UIViewController *currentVC = self.childVCArray[index];
    currentVC.view.frame = CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT - 50 - kTabBarPadding);
    if ([currentVC isEqual:self.currentVC]) {
        return;
    }

    [self replaceWithOldController:self.currentVC newController:currentVC];
}

- (void)replaceWithOldController:(UIViewController *)oldVC newController:(UIViewController *)newVC {
    if (oldVC) {
        [oldVC.view removeFromSuperview];
    }
    self.currentVC = newVC;

    [self addChildViewController:newVC];
    [self.view addSubview:newVC.view];
    [self.view bringSubviewToFront:self.tabBarView];
}

- (void)loadElectricHomeVC:(BOOL)hasScanAuthority {
    for (UIViewController *vc in [DolinTabBarController sharedInstance].childViewControllers) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }

    DLTabModel *tabModel1 = DLTabInfoModel(@"DOLIN1", nil, @"tab_main_nor", @"tab_main_sel");
    DLTabModel *tabModel2 = DLTabInfoModel(@"DOLIN2", nil, @"tab_music_nor", @"tab_music_sel");
    DLTabModel *tabModel3 = DLTabInfoModel(@"", @"", @"", @"");
    DLTabModel *tabModel4 = DLTabInfoModel(@"DOLIN3", nil, @"tab_friend_nor", @"tab_friend_sel");
    DLTabModel *tabModel5 = DLTabInfoModel(@"DOLIN4", nil, @"tab_discover_nor", @"tab_discover_sel");
    UIViewController *vc1 = [[NSClassFromString(@"Dolin1VC") alloc] init];
    UIViewController *vc2 = [[NSClassFromString(@"Dolin2VC") alloc] init];
    UIViewController *vc3 = [[NSClassFromString(@"Dolin3VC") alloc] init];
    UIViewController *vc4 = [[NSClassFromString(@"Dolin4VC") alloc] init];
    if (hasScanAuthority) {
        self.childVCArray = [NSMutableArray arrayWithArray:@[vc1, vc2, [UIViewController new], vc3, vc4]];
        self.tabarModelArray = [NSMutableArray arrayWithArray:@[tabModel1,tabModel2,tabModel3,tabModel4,tabModel5]];
    } else {
        self.childVCArray = [NSMutableArray arrayWithArray:@[vc1, vc2, vc3, vc4]];
        self.tabarModelArray = [NSMutableArray arrayWithArray:@[tabModel1,tabModel2,tabModel4,tabModel5]];
    }
}

@end

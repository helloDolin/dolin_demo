//
//  LaunchViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/14.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "LaunchViewController.h"
#import "UIImageView+WebCache.h"

static CGFloat const kAnimationDuration = 0.5;

@interface LaunchViewController ()

@property (nonatomic, strong) UIImageView *launchImageView;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView* mtImgView;

@end

@implementation LaunchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.launchImageView];
//    [self.view addSubview:self.lblTitle];
    [self.view addSubview:self.mtImgView];
    
    [self animate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method
- (void)animate {
    [UIView animateWithDuration:kAnimationDuration animations:^ {
        self.mtImgView.frame = CGRectMake(0, 0, 50, 50);
        self.mtImgView.center = self.view.center;
        self.launchImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.mtImgView.frame = CGRectMake(0, 0, 5000, 5000);
            self.mtImgView.center = self.view.center;
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
    }];
}

#pragma mark -  getter
- (UIImageView *)launchImageView {
    
    if (!_launchImageView) {
        _launchImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _launchImageView.image = [UIImage imageNamed:@"launch_img"];
        
        // 也可以从服务器拿图片
//        [_launchImageView sd_setImageWithURL:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //
//        }];
    }
    
    return _launchImageView;
}

- (UILabel *)lblTitle{
    
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 45)];
        _lblTitle.text = @"dolin demo";
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = [UIFont boldSystemFontOfSize:45];
    }
    
    return _lblTitle;
}

- (UIImageView*)mtImgView {
    if (!_mtImgView) {
        _mtImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MT"]];
        _mtImgView.frame = CGRectMake(0, 0, 150, 150);
        _mtImgView.center = self.view.center;
    }
    return _mtImgView;
}


@end

//
//  LaunchViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/14.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "LaunchViewController.h"
#import "UIImageView+WebCache.h"

static CGFloat const kAnimationDuration = 3.0;

@interface LaunchViewController ()

@property (nonatomic, strong) UIImageView *launchImageView;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation LaunchViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.launchImageView];
    [self.view addSubview:self.lblTitle];
    
    [self animate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method
- (void)animate {
//    [UIView animateWithDuration:kAnimationDuration animations:^{
//        // 这里先把View缩小
//        _lblTitle.frame = CGRectMake(0, 0, 50, 50);
//        _lblTitle.center = self.view.center;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            // 这里要把View放大
//            _lblTitle.frame = CGRectMake(0, 0, 5000, 5000);
//            _lblTitle.center = self.view.center;
//            _lblTitle.alpha = 0;
//        } completion:^(BOOL finished) {
//            [_lblTitle removeFromSuperview];
//        }];;
//    }];
    
    
    [UIView animateWithDuration:kAnimationDuration animations:^ {
        self.launchImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
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



@end

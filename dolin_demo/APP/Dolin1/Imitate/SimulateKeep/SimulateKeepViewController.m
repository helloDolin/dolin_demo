//
//  SimulateKeepViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/15.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SimulateKeepViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#import "SimulateKeepScroll.h"

@interface SimulateKeepViewController ()
{
    MPMoviePlayerController *_moviePlayer;
}

@property(nonatomic,strong)SimulateKeepScroll* simulateKeepScroll;
@property(nonatomic,strong)UILabel* lblLogo;
@property(nonatomic,strong)UIButton* registBtn;
@property(nonatomic,strong)UIButton* loginBtn;

@end

@implementation SimulateKeepViewController

#pragma mark -  life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNoInterruptOtherMusic];
    [self layoutUI];
    [self setupUIConstraint];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
    [_moviePlayer stop];
}

#pragma mark -  method
- (void)layoutUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMoviePlayer];
    [self.view addSubview:self.lblLogo];
    [self.view addSubview:self.simulateKeepScroll];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.loginBtn];
}

- (void)setupUIConstraint {
    
    [self.lblLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(3.0);
        make.top.equalTo(self.view.mas_top).offset(80.0);
        make.right.equalTo(self.view.mas_right).offset(-3.0);
        make.height.greaterThanOrEqualTo(@30.0);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10.0);
        make.right.equalTo(self.view.mas_centerX).offset(-10.0);
        make.height.equalTo(@40.0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10.0);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(10.0);
        make.right.equalTo(self.view.mas_right).offset(-10.0);
        make.height.equalTo(self.registBtn.mas_height);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10.0);
    }];
}

- (void)playbackStateChanged {
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}

- (void)setupMoviePlayer {
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"keep.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    
    [self.view addSubview:_moviePlayer.view];
    
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];
    
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
}

/**
 *  不打断其他音乐
 */
- (void)setNoInterruptOtherMusic {
    // AVAudioSessionCategoryAmbient
    /*  Use this category for background sounds such as rain, car engine noise, etc.
     Mixes with other music. */
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
}

- (void)btnAtion {
    NSLog(@"点击 注册或者登录按钮");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  getter
- (UILabel*)lblLogo {
    if (!_lblLogo) {
        _lblLogo = [[UILabel alloc]init];
        _lblLogo.text = @"dolin demo";
        _lblLogo.textAlignment = NSTextAlignmentCenter;
        _lblLogo.textColor = [UIColor whiteColor];
        _lblLogo.font = [UIFont boldSystemFontOfSize:30];
    }
    return _lblLogo;
}

- (SimulateKeepScroll*)simulateKeepScroll {
    if (!_simulateKeepScroll) {
        _simulateKeepScroll = [[SimulateKeepScroll alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 80)   
            WithTexts:@[@"对酒当歌",@"人生几何",@"譬如朝露",@"去日苦多",@"唯有杜康"]
                                                        dotColorNormal:RANDOM_UICOLOR
                                                       dotColorCurrent:[UIColor whiteColor]];
    }
    return _simulateKeepScroll;
}

- (UIButton*)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registBtn.backgroundColor = [UIColor blackColor];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registBtn.layer.cornerRadius = 3.0f;
        _registBtn.alpha = 0.4f;
        [_registBtn addTarget:self action:@selector(btnAtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}

- (UIButton*)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor whiteColor];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 3.0f;
        _loginBtn.alpha = 0.4f;
        [_loginBtn addTarget:self action:@selector(btnAtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
@end

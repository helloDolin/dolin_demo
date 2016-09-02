//
//  Dolin2ViewController.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "PlayMusicViewController.h"
#import "PlayManager.h"
#import "Music.h"
#import "RequestManager.h"

@interface PlayMusicViewController ()<playManagerDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>

//歌词tableView
@property(nonatomic,strong) UITableView *tableView;
//当前播放时间
@property(nonatomic,strong) UILabel *currentTime;
//总共时间
@property(nonatomic,strong) UILabel *totalTime;
//当前进度
@property(nonatomic,strong) UISlider *slider;
//歌曲音量
@property(nonatomic,strong)UISlider *theVolumeSlider;
//背景View
@property (strong,nonatomic) IBOutlet UIView *backgroundView;
//背景图片(封面)
@property(nonatomic,strong)UIImageView *backgroundImage;
//存放时间数组
@property(nonatomic,strong)NSMutableArray *timeArray;
//歌词数组
@property(nonatomic,strong)NSMutableArray *lyicArray;
//记录正在播放的下标
@property(nonatomic,assign)NSInteger currentIndex;
//毛玻璃
@property(nonatomic,strong)UIBlurEffect *blureffect;
//毛玻璃
@property(nonatomic,strong)UIVisualEffectView *visualeffectview;
//延时动画
@property(nonatomic,strong)CATransition *transition;
//CD盘透明背景
@property(nonatomic,strong)UIImageView *cdBackground;
//CD盘与磁针背景
@property(nonatomic,strong)UIView *cdAndneedleBackground;
//CD滚动视图
@property(nonatomic,strong)UIScrollView *cdScrollView;
//左CD盘
@property(nonatomic,strong)UIImageView *cdLeftImage;
//中CD盘
@property(nonatomic,strong) UIImageView *cdInTheMiddleImage;
//右CD盘
@property(nonatomic,strong)UIImageView *cdRightImage;
//左CD封面
@property(nonatomic,strong)UIImageView *cdLeftTheCover;
//中CD封面
@property(nonatomic,strong)UIImageView *cdInTheMiddleTheCover;
//右CD封面
@property(nonatomic,strong)UIImageView *cdRightTheCover;

//磁针
@property(nonatomic,strong)UIImageView *needleImageView;
//喜欢按钮
@property(nonatomic,strong)UIButton *likeBtn;
//下载按钮
@property(nonatomic,strong)UIButton *downloadBtn;
//评论按钮
@property(nonatomic,strong)UIButton *commentsBtn;
//更多按钮
@property(nonatomic,strong)UIButton *moreBtn;
//喜欢按钮的照片(空心)
@property(nonatomic,strong)UIImage *likeImage;
//喜欢按钮的照片(红心)
@property(nonatomic,strong)UIImage *likedImage;
//下载按钮图片
@property(nonatomic,strong)UIImage *downloadImage;
//下载成功按钮图片
@property(nonatomic,strong)UIImage *downloadOkImage;
//记录正在播放的歌曲url
@property(nonatomic,strong)NSString *mp3Url;
//下载的MP3的路径
@property(nonatomic,strong)NSString *musicDownloadString;
//歌曲ID
@property(nonatomic,strong)NSString *musicID;
//Scroll和tableView手势
@property(nonatomic,strong)UITapGestureRecognizer *singleFingerOne;
//网络状态
@property(nonatomic,strong)NSError *networkInformationError;
//正在下载的歌曲路径字符串
@property(nonatomic,strong)NSString *isDownloadingUrlString;
//上一首
@property(nonatomic,strong)UIButton *playLastOne;
//下一首
@property(nonatomic,strong)UIButton *playNextOne;
//播放/暂停
@property(nonatomic,strong)UIButton *playOrPause;
//循环状态
@property(nonatomic,strong)UIButton *circulation;
//歌曲列表
@property(nonatomic,strong)UIButton *musicList;
//音量图标
@property(nonatomic,strong)UIImageView *volumeImage;
//AirPlay图标
@property(nonatomic,strong)UIImageView *AirPlayImage;

//歌曲名称
@property(nonatomic,strong)UILabel *musicName;
//歌手名称
@property(nonatomic,strong)UILabel *singerName;

@end

@implementation PlayMusicViewController

//音量图标
-(UIImageView *)volumeImage{
    if (!_volumeImage) {
        _volumeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kHeight *0.02f, kHeight*0.094f, kHeight*0.045, kHeight *0.045)];
        _volumeImage.image =[UIImage imageNamed:@"cm2_fm_vol_speaker@3x"];
    }
    return _volumeImage;
}

//AirPlay图标
- (UIImageView *)AirPlayImage{
    if (!_AirPlayImage) {
        _AirPlayImage = [[UIImageView alloc]initWithFrame:CGRectMake(kHeight *0.498f, kHeight*0.094f, kHeight*0.045, kHeight *0.045)];
        _AirPlayImage.image =[UIImage imageNamed:@"cm2_play_icn_airplay@3x"];
    }
    return _AirPlayImage;
}

//tableView懒加载
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,kHeight *0.159f , kWidth, kHeight*0.619f) style:UITableViewStylePlain];
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor clearColor];
        //去掉线
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
//歌词数组懒加载
-(NSMutableArray *)lyicArray{
    if (!_lyicArray) {
        _lyicArray =[NSMutableArray array];
    }
    return _lyicArray;
}

//控制器的单例
+ (instancetype)sharedManager {
    static PlayMusicViewController *handle =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[PlayMusicViewController alloc]init];
    });
    return handle;
}

//加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIView *musicNameAndSinger = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kHeight *0.394f, 40)];
    //musicNameAndSinger.backgroundColor =[UIColor redColor];
    
    self.musicName = [[UILabel alloc]initWithFrame:CGRectMake(-18, 0, kHeight *0.394f, kHeight *0.0321f)];
    self.musicName.textColor=[UIColor whiteColor];
    self.musicName.textAlignment = NSTextAlignmentCenter ;//居中
    [musicNameAndSinger addSubview:self.musicName];
    
    self.singerName = [[UILabel alloc]initWithFrame:CGRectMake(-18, kHeight *0.0321f, kHeight *0.394f, kHeight*0.023f)];
    self.singerName.textColor =[UIColor whiteColor];
    self.singerName.textAlignment = NSTextAlignmentCenter;
    self.singerName.font =[UIFont systemFontOfSize:12];
    [musicNameAndSinger addSubview:self.singerName];
    self.navigationItem.titleView =musicNameAndSinger;
    
    
    
    //消除顶部空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //背景照片初始化
    self.backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kWidth,kHeight)];
    [self.backgroundImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.backgroundImage.clipsToBounds = YES;
    
    //CD盘后透明图片初始化
    self.cdBackground = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    //时间数组初始化
    self.timeArray =[NSMutableArray array];
    //为了防止点击第一首歌的时候不能播放
    self.currentIndex = -1;
    
    //毛玻璃
    //创建需要的毛玻璃特效类型
    self.blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //添加毛玻璃view视图
    self.visualeffectview = [[UIVisualEffectView alloc]initWithEffect:self.blureffect];
    //设置毛玻璃的view视图的大小
    self.visualeffectview.frame = CGRectMake(0, 0,kWidth,kHeight);
    //设施模糊的透明度
    self.visualeffectview.alpha = 0.975f;
    
    //CD盘的透明背景图片
    self.cdBackground.image = [UIImage imageNamed:@"cm2_play_disc_mask@3x"];
    
    
    //添加背景照片到view上
    [self.backgroundView insertSubview:self.backgroundImage atIndex:0];
    
    //将模糊添加到背景上
    [self.backgroundView insertSubview: self.visualeffectview atIndex:1];
    

    
    //将CD盘的透明背景添加到背景上
    [self.backgroundView insertSubview:self.cdBackground atIndex:2];
    
    
    
    //延时动画
    self.transition = [CATransition animation];
    self.transition.duration = 2.0f;
    self.transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.transition.type = kCATransitionFade;
    
    //磁针背景
    self.cdAndneedleBackground =[[UIView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64)];
    self.cdAndneedleBackground.clipsToBounds =YES;
    [self.backgroundView addSubview:self.cdAndneedleBackground];
    
    //CD盘滚动视图
    self.cdScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , kWidth, kHeight *0.6805f)];
    self.cdScrollView.contentSize = CGSizeMake(kWidth *3, kHeight *0.675f);
    self.cdScrollView.backgroundColor =[UIColor clearColor];
    //分页滚动
    self.cdScrollView.pagingEnabled =YES;
    [self.cdAndneedleBackground addSubview:self.cdScrollView];
    //设置才开始的界面
    self.cdScrollView.contentOffset = CGPointMake(kWidth, 0);
    self.cdScrollView.showsHorizontalScrollIndicator = NO;
    //协议
    self.cdScrollView.delegate =self;
    
    
    //中间cd盘
    self.cdInTheMiddleImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2 -(kHeight*0.2142f)+kWidth,self.cdScrollView.frame.size.height/2-kHeight*0.2142f, kHeight*0.4284f, kHeight*0.4284f)];
    self.cdInTheMiddleImage.image =[UIImage imageNamed:@"cm2_default_cover_play@3x"];
    //让背景图变圆
    self.cdInTheMiddleImage.layer.cornerRadius = CGRectGetWidth(self.cdInTheMiddleImage.frame)/2;
    self.cdInTheMiddleImage.layer.masksToBounds =YES;
    self.cdInTheMiddleImage.alpha = 0.9f;
    [self.cdScrollView insertSubview:self.cdInTheMiddleImage atIndex:0];

    
    //左边cd盘
    self.cdLeftImage =[[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2 -(kHeight*0.2142f),self.cdScrollView.frame.size.height/2-kHeight*0.2142f, kHeight*0.4284f, kHeight*0.4284f)];
    self.cdLeftImage.layer.cornerRadius =self.cdLeftImage.frame.size.width/2;
    self.cdLeftImage.layer.masksToBounds =YES;
    self.cdLeftImage.image =[UIImage imageNamed:@"cm2_default_cover_play@3x"];
    [self.cdScrollView insertSubview:self.cdLeftImage atIndex:1];
    
    
    //右边cd盘
    self.cdRightImage =[[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2 -(kHeight*0.2142f) + kWidth * 2,self.cdScrollView.frame.size.height/2-kHeight*0.2142f, kHeight*0.4284f, kHeight*0.4284f)];
    self.cdRightImage.layer.cornerRadius =self.cdRightImage.frame.size.width/2;
    self.cdRightImage.layer.masksToBounds =YES;
    self.cdRightImage.image = [UIImage imageNamed:@"cm2_default_cover_play@3x"];
    [self.cdScrollView insertSubview:self.cdRightImage atIndex:2];
    
    
    //左边封面
    self.cdLeftTheCover = [[UIImageView alloc]initWithFrame:CGRectMake(self.cdInTheMiddleImage.frame.size.width/2 -(kWidth*0.25f), self.cdInTheMiddleImage.frame.size.height/2-(kWidth*0.25f) , kWidth*0.5f, kWidth*0.5f)];
    //让背景图变圆
    self.cdLeftTheCover.layer.cornerRadius = CGRectGetWidth(self.cdLeftTheCover.frame)/2;
    self.cdLeftTheCover.layer.masksToBounds =YES;
    //设置边框
    self.cdLeftTheCover.layer.borderWidth = 5;
    self.cdLeftTheCover.layer.borderColor =[[UIColor blackColor]CGColor];
    [self.cdLeftImage insertSubview: self.cdLeftTheCover atIndex:4];
    self.cdLeftTheCover.backgroundColor =[UIColor clearColor];
    
    
    //中间封面
    self.cdInTheMiddleTheCover = [[UIImageView alloc]initWithFrame:CGRectMake(self.cdInTheMiddleImage.frame.size.width/2 -(kWidth*0.25f), self.cdInTheMiddleImage.frame.size.height/2-(kWidth*0.25f) , kWidth*0.5f, kWidth*0.5f)];
    //让背景图变圆
    self.cdInTheMiddleTheCover.layer.cornerRadius = CGRectGetWidth(self.cdInTheMiddleTheCover.frame)/2;
    self.cdInTheMiddleTheCover.layer.masksToBounds =YES;
    //设置边框
    self.cdInTheMiddleTheCover.layer.borderWidth = 5;
    self.cdInTheMiddleTheCover.layer.borderColor =[[UIColor blackColor]CGColor];
    [self.cdInTheMiddleImage addSubview:self.cdInTheMiddleTheCover];
    self.cdInTheMiddleTheCover.backgroundColor =[UIColor clearColor];
    
    
    //右边封面
    self.cdRightTheCover = [[UIImageView alloc]initWithFrame:CGRectMake(self.cdInTheMiddleImage.frame.size.width/2 -(kWidth*0.25f), self.cdInTheMiddleImage.frame.size.height/2-(kWidth*0.25f) , kWidth*0.5f, kWidth*0.5f)];
    //让背景图变圆
    self.cdRightTheCover.layer.cornerRadius = CGRectGetWidth(self.cdRightTheCover.frame)/2;
    self.cdRightTheCover.layer.masksToBounds =YES;
    //设置边框
    self.cdRightTheCover.layer.borderWidth = 5;
    self.cdRightTheCover.layer.borderColor =[[UIColor blackColor]CGColor];
    [self.cdRightImage insertSubview: self.cdRightTheCover atIndex:5];
    self.cdRightTheCover.backgroundColor =[UIColor clearColor];
    
    
    
    
    //喜欢按钮
    self.likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.15f, kHeight*0.76f, kHeight*0.06f, kHeight*0.06f)];
    self.likeImage = [UIImage imageNamed:@"cm2_play_icn_love@3x"];
    self.likedImage = [UIImage imageNamed:@"cm2_play_icn_loved@3x"];
    [self.likeBtn setImage:self.likeImage forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.likeBtn];
    
    //下载按钮
    self.downloadBtn =[[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.36f, kHeight*0.76f, kHeight*0.06f, kHeight*0.06f)];
    self.downloadImage = [UIImage imageNamed:@"cm2_play_icn_dld@3x"];
    self.downloadOkImage =[UIImage imageNamed:@"cm2_mv_btn_dlded@3x"];
    [self.downloadBtn setImage:self.downloadImage forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.downloadBtn];
    
    //评论按钮
    self.commentsBtn =[[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.57f, kHeight*0.76f, kHeight*0.06f, kHeight*0.06f)];
    [self.commentsBtn setImage:[UIImage imageNamed:@"cm2_play_icn_cmt@3x"] forState:UIControlStateNormal];
    [self.commentsBtn addTarget:self action:@selector(commentsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.commentsBtn];
    
    
    //更多按钮
    self.moreBtn =[[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.77f, kHeight*0.76f, kHeight*0.06f, kHeight*0.06f)];
    [self.moreBtn setImage:[UIImage imageNamed:@"cm2_play_icn_more@3x"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.moreBtn];
    
    
    //手势
    self.singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerIncident)];
    //手指数
    self.singleFingerOne.numberOfTouchesRequired = 1;
    //点击次数
    self.singleFingerOne.numberOfTapsRequired = 1;
    //设置代理方法
    self.singleFingerOne.delegate= self;
    //增加事件者响应者，
    [self.cdScrollView addGestureRecognizer:self.singleFingerOne];
    
 
        //遵循传值代理
        [PlayManager sharedManager].delegate =self;
        //设置用户交互
    //    self.tableView.userInteractionEnabled =YES;
        //注册tableView
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    //选择自己喜欢的颜色
    UIColor * color = [UIColor whiteColor];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    //标题颜色
    self.navigationController.navigationBar.titleTextAttributes = dict;
    //按钮颜色
    self.navigationController.navigationBar.tintColor = color;
    //分享按钮
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cm2_topbar_icn_share@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    //初始化左边时间栏
    self.currentTime = [[UILabel alloc]initWithFrame:CGRectMake(10, kHeight*0.835f, kHeight*0.049f, kHeight*0.023f)];
    self.currentTime.textColor =[UIColor whiteColor];
    self.currentTime.text =@"00:00";
    self.currentTime.font = [UIFont systemFontOfSize:11];
    [self.backgroundView addSubview:self.currentTime];
    
    //初始化右边时间栏
    self.totalTime =[[UILabel alloc]initWithFrame:CGRectMake(kHeight*0.51f, kHeight*0.835f, kHeight*0.049f, kHeight*0.023f)];
    self.totalTime.textColor =[UIColor grayColor];
    self.totalTime.text =@"00:00";
    self.totalTime.font = [UIFont systemFontOfSize:11];
    [self.backgroundView addSubview:self.totalTime];
    
    //初始化进度条
    self.slider=[[UISlider alloc]initWithFrame:CGRectMake(kHeight *0.069f, kHeight*0.836f, kHeight*0.418, kHeight *0.024f)];
    [self.slider setThumbImage:[UIImage imageNamed:@"cm2_fm_playbar_btn@3x"] forState:UIControlStateNormal];
    [self.slider setMaximumValue:1];
    [self.slider setMinimumValue:0];
    self.slider.minimumTrackTintColor =[UIColor redColor];
    self.slider.maximumTrackTintColor =[UIColor grayColor];
    [self.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.backgroundView addSubview:self.slider];
    
    
    //循环方式
    self.circulation = [[UIButton alloc]initWithFrame:CGRectMake(kHeight *0.009f, kHeight *0.89f, kHeight *0.072f, kHeight *0.072f)];
    [self.circulation setImage:[UIImage imageNamed:@"cm2_icn_loop@3x"] forState:UIControlStateNormal];
    [self.circulation addTarget:self action:@selector(circulationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.circulation];
    
    //歌曲列表
    self.musicList = [[UIButton alloc]initWithFrame:CGRectMake(kHeight *0.48f, kHeight *0.89f, kHeight *0.072f, kHeight *0.072f)];
    [self.musicList setImage:[UIImage imageNamed:@"cm2_icn_list@3x"] forState:UIControlStateNormal];
    [self.musicList addTarget:self action:@selector(musicListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.musicList];
    
    
    //上一曲
    self.playLastOne = [[UIButton alloc]initWithFrame:CGRectMake(kHeight *0.14f, kHeight *0.9f, kHeight *0.045f, kHeight *0.045f)];
    [self.playLastOne setImage:[UIImage imageNamed:@"cm2_vehicle_btn_prev_prs@3x"] forState:UIControlStateNormal];
    [self.playLastOne addTarget:self action:@selector(playLastOneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.playLastOne];
    
    //播放/暂停
    self.playOrPause = [[UIButton alloc]initWithFrame:CGRectMake(kHeight *0.244f, kHeight *0.886f, kHeight *0.0815f, kHeight *0.0815f)];
    [self.playOrPause setImage:[UIImage imageNamed:@"cm2_vehicle_btn_pause_prs@3x"] forState:UIControlStateNormal];
    [self.playOrPause addTarget:self action:@selector(playOrPauseAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundView addSubview:self.playOrPause];
    
    //下一曲
    self.playNextOne = [[UIButton alloc]initWithFrame:CGRectMake(kHeight *0.375f, kHeight *0.9f, kHeight *0.045f, kHeight *0.045f)];
    [self.playNextOne setImage:[UIImage imageNamed:@"cm2_vehicle_btn_next_prs@3x"] forState:UIControlStateNormal];
    [self.playNextOne addTarget:self action:@selector(playNextOneAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundView addSubview:self.playNextOne];
   
    //歌曲音量
    self.theVolumeSlider =[[UISlider alloc]initWithFrame:CGRectMake(kHeight *0.068f, kHeight *0.1f, kHeight *0.417f, kHeight *0.03f)];
    self.theVolumeSlider.value = 0.5f;
    [self.theVolumeSlider setMaximumValue:1];
    [self.theVolumeSlider setMinimumValue:0];
    self.theVolumeSlider.minimumTrackTintColor =[UIColor whiteColor];
    self.theVolumeSlider.maximumTrackTintColor =[UIColor grayColor];
    [self.theVolumeSlider setThumbImage:[UIImage imageNamed:@"cm2_vol_btn@3x"] forState:UIControlStateNormal ];
    
    [self.theVolumeSlider addTarget:self action:@selector(theVolumeSliderAction) forControlEvents:UIControlEventValueChanged];
    
    //磁针
    self.needleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth*0.3059f, kHeight*0.2663f)];
    self.needleImageView.image = [UIImage imageNamed:@"cm2_play_needle_play@3x"];
    [self.cdAndneedleBackground addSubview:self.needleImageView];
    self.needleImageView.layer.position = CGPointMake(kWidth*0.5f, 0);
    self.needleImageView.layer.anchorPoint =CGPointMake(0.2526f, 0.1632f);
    self.needleImageView.transform =CGAffineTransformMakeRotation(-0.5f);
    
   
}
//设置播放信息
-(void)setMusicInfoWithIndex:(NSInteger)index {
    
    
    
    //清除歌词上次数组信息
    if (self.timeArray.count>0) {
        [self.timeArray removeAllObjects];
        [self.lyicArray removeAllObjects];
    }
    
    //获取对应下标的音乐
    Music *music =[[RequestManager sharedManager]returnMusicAtIndex:index];
    
    
    //子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //下载的MP3的路径
        self.musicDownloadString = [NSString stringWithFormat:@"%@/%@.mp3",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject,music.musicDownloadID];
        
        //检测网络状态
        self.networkInformationError = [[RequestManager sharedManager]networkInformation];
        
        //查找有没有本地歌曲文件
        if ([[NSFileManager defaultManager]fileExistsAtPath:self.musicDownloadString]) {
            
            NSLog(@"有下载的文件,我去播放了");
            [[PlayManager sharedManager]downloadMusicPlay:self.musicDownloadString ];
            //歌曲路径
            NSLog(@"%@",self.musicDownloadString);
            
            //在主线程替换成下载完成的图标
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.downloadBtn setImage:self.downloadOkImage forState:UIControlStateNormal];
            });
            
        }else{
            //本地没有文件,替换成下载图标
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.downloadBtn setImage:self.downloadImage forState:UIControlStateNormal];
            
            });
            
            //网络正常的话,去播放网络音乐
            if (!self.networkInformationError) {
            
                [[PlayManager sharedManager]prepareToPlayMusicWithUrl:music.mp3Url];
                self.mp3Url =music.mp3Url;
                NSLog(@"网络正常,有网络歌曲我去播放了");
                
                
                
                
                
            }else{
                NSLog(@"网络错误,无法播放网络歌曲");
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //初始化弹窗
                    MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
                    [message showAlertWith:@"没有网络\n只能播放本地歌曲"];
                });
            }
            
            
            
        }
        
        
        //歌词
        
        NSString *lyricUrlString = [NSString stringWithFormat:@"%@%@",kLyricUrl,music.musicID];
        //设置网络请求
        NSURLRequest *lyricRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:lyricUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
        //发送请求
        NSError *error =nil;
        NSData *lyricData =[NSURLConnection sendSynchronousRequest:lyricRequest returningResponse:nil error:&error];
        
        if (!error) {
            //解析数据
            NSDictionary *lyricDic = [NSJSONSerialization JSONObjectWithData:lyricData options:NSJSONReadingAllowFragments error:nil];
           NSString  * lyricString = lyricDic[@"lyric"];
        
            //分析歌词
            //根据反\n对歌曲进行切割
            NSArray *array  =  [lyricString componentsSeparatedByString:@"\n"];
            for (NSString *string in array) {
                //根据"]"把时间和歌词分离
                NSArray *arrayTwo = [string componentsSeparatedByString:@"]"];
                
                //判断如果存在时间和歌词的话,再对时间进行截取
                if (arrayTwo.count == 2) {
//                    NSLog(@"%@,%@",arrayTwo[0],arrayTwo[1]);
                    if ([arrayTwo[0] length] >6) {
                        NSString *time = [arrayTwo[0] substringWithRange:NSMakeRange(1, 5)];
                        [self.timeArray addObject:time];
                        [self.lyicArray addObject:arrayTwo[1]];
                    }
                    
                }
            }
            
        }else{
            NSLog(@"请求歌词发生错误,网络有问题");
        }


        //主线程,主要用来刷新ui(使用完子线程后,要回到主线程)
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            self.musicName.text =music.name;//歌名
            self.singerName.text =music.singer;//歌手
            
            //更换背景图片
            [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:music.picUrl] ];
            //动画
            [self.backgroundImage.layer addAnimation:self.transition forKey:nil];
            
            //CD封面图
            [self.cdInTheMiddleTheCover sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];

            
            if (index == 0) {
                Music *music =[[RequestManager sharedManager]returnMusicAtIndex:[[RequestManager sharedManager]returnArrayCount]-1];
                [self.cdLeftTheCover sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];
                Music *music2 =[[RequestManager sharedManager]returnMusicAtIndex:index+1];
                [self.cdRightTheCover sd_setImageWithURL:[NSURL URLWithString:music2.picUrl]];
                
            }
            
            
            if (index ==[[RequestManager sharedManager]returnArrayCount]-1) {
                Music *music =[[RequestManager sharedManager]returnMusicAtIndex:index-1];
                [self.cdLeftTheCover sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];
                
                Music *music2 =[[RequestManager sharedManager]returnMusicAtIndex:0];
                [self.cdRightTheCover sd_setImageWithURL:[NSURL URLWithString:music2.picUrl]];
            }
            
            if (index-1 > 0 && index  <[[RequestManager sharedManager]returnArrayCount]-1) {
                Music *music =[[RequestManager sharedManager]returnMusicAtIndex:index-1];
                [self.cdLeftTheCover sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];
                
                Music *music2 =[[RequestManager sharedManager]returnMusicAtIndex:index+1];
                [self.cdRightTheCover sd_setImageWithURL:[NSURL URLWithString:music2.picUrl]];
            }
            
          
            
            //刷新ui
            [self.tableView reloadData];
        });
    });
    //播放时放磁针
    [UIView animateWithDuration:0.4f animations:^{
        self.needleImageView.transform =CGAffineTransformMakeRotation(0);
    }];
}

//播放上一首
- (void)playLastOneAction{
     [self.cdScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

//播放下一首
- (void)playNextOneAction{
    [self.cdScrollView setContentOffset:CGPointMake(kWidth*2, 0) animated:YES];
}

//播放/暂停
- (void)playOrPauseAction{
    if ([[PlayManager sharedManager] isPlaying] == NO) {
        //播放动画(放磁针)
        [UIView animateWithDuration:0.4f animations:^{
        self.needleImageView.transform =CGAffineTransformMakeRotation(0);
            
            }];
        [[PlayManager sharedManager] playMusic];
        
        [self.playOrPause setImage:[UIImage imageNamed:@"cm2_vehicle_btn_pause_prs@3x"] forState:UIControlStateNormal];
        
    }else{
        
        //暂停动画(取磁针)
        [UIView animateWithDuration:0.4f animations:^{
            
            self.needleImageView.transform =CGAffineTransformMakeRotation(-0.5f);
        }];
        
        [[PlayManager sharedManager] pasuseMusic];
        
        [self.playOrPause setImage:[UIImage imageNamed:@"cm2_vehicle_btn_play_prs@3x"] forState:UIControlStateNormal];
        
    }
    
    
}

//快进快退事件
- (void)sliderAction:(UISlider *)sender {
    [[PlayManager sharedManager]playMusicWithSliderValue:sender.value];
}


//视图将要出现的时候
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent =YES;
    UIColor *color =[UIColor clearColor];
    CGRect rect =CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //为了防止点同一首歌重新播放的情况发生
    if (self.index != self.currentIndex) {
        self.currentIndex = self.index;
        //设置信息
        [self setMusicInfoWithIndex:self.currentIndex];
    }
    
}

//实现代理协议
-(void)playManagerDelegateFetchTotalTime:(NSString *)totalTime currentTime:(NSString *)currentTime progress:(CGFloat)progress{
    //赋值
    self.totalTime.text = totalTime;
    self.currentTime.text =currentTime;
    self.slider.value = progress;
    
    //让图片实现旋转
    [UIView animateWithDuration:0.1 animations:^{
        self.cdInTheMiddleImage.transform = CGAffineTransformRotate(self.cdInTheMiddleImage.transform, M_PI/130);
    }];
    


    //让歌词和歌曲实时同步
    if ([self.timeArray containsObject:currentTime] && self.timeArray.count != 0 ) {
        NSInteger index = [self.timeArray indexOfObject:currentTime];
        //让tableview对应的cell变成选中状态
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index+5 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

//自动播放下一首
-(void)playToNextMusic{
    [self playNextOneAction];
}

#pragma  mark -------歌词TableViewDelegate----------
//个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.timeArray.count == 0) {
        return 6;
    }
    return self.timeArray.count+10;
}
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //初始化cell
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.textLabel.textColor =[UIColor grayColor];
    //被选中时的颜色
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    //居中
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //自动换行
    cell.textLabel.numberOfLines = 0;
    //选中的背景为空
    cell.selectedBackgroundView = [UIView new];
    //cell背景置为透明色
    cell.backgroundColor = [UIColor clearColor];
    
    //如果网络不好的话
    if (self.networkInformationError) {
        if (indexPath.row == 5) {
            //字体颜色
//            cell.textLabel.textColor = [UIColor whiteColor];
            
            cell.textLabel.text =@"没有网络,无法加载歌词";
        }else{
            cell.textLabel.textColor =[UIColor clearColor];
            cell.textLabel.text =@"正在加载中,请稍后...";
        }
        
        
        return cell;
        
    }
  
    //如果歌词文件不存在
    if (self.timeArray.count == 0) {
    
        if (indexPath.row == 5) {
            //字体颜色
            cell.textLabel.textColor = [UIColor whiteColor];
            
            cell.textLabel.text =@"纯音乐,无歌词";
        }else{
            cell.textLabel.textColor =[UIColor clearColor];
            cell.textLabel.text =@"正在加载中,请稍后...";
        }
        
        return cell;
    }
    
    if (indexPath.row <5 || indexPath.row > self.timeArray.count +4) {
    
        cell.textLabel.textColor =[UIColor clearColor];
        cell.textLabel.text = @"";
        return cell;
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = self.lyicArray[indexPath.row-5];
    }
    

    return cell;
}

#pragma mark -------滑动换歌---------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x != kWidth) {
        [UIView animateWithDuration:0.4f animations:^{

      self.needleImageView.transform =CGAffineTransformMakeRotation(-0.5f);
        }];
        
    }else{
        //如果没播放歌曲的话不放磁针
        if ([[PlayManager sharedManager] isPlaying] != NO) {
            [UIView animateWithDuration:0.4f animations:^{
                self.needleImageView.transform =CGAffineTransformMakeRotation(0);
            }];
        }
       
    }
    
    
    
    
    if (scrollView.contentOffset.x == 0   ) {
        
        //设置偏移量为屏宽
        scrollView.contentOffset = CGPointMake(kWidth, 0);
         //恢复CD盘角度为0
        self.cdInTheMiddleImage.transform =CGAffineTransformMakeRotation(0);
        //设置中间CD盘的图片为左边CD盘
        self.cdInTheMiddleTheCover.image = self.cdLeftTheCover.image;
       
        //如果是第一首歌,点击后播放最后一首
        if (self.currentIndex == 0) {
            self.currentIndex = [[RequestManager sharedManager]returnArrayCount]-1;
        }else{
            self.currentIndex--;
        }
        //设置播放信息
        [self setMusicInfoWithIndex:self.currentIndex];
        
       
    }
    

    //右滑执行
    if (scrollView.contentOffset.x == kWidth*2 ) {
        
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        self.cdInTheMiddleImage.transform =CGAffineTransformMakeRotation(0);
        self.cdInTheMiddleTheCover.image = self.cdRightTheCover.image;
        
        //如果是最后一首的话,播放第一首
        if (self.currentIndex == [[RequestManager sharedManager]returnArrayCount]-1) {
            self.currentIndex = 0;
        }else{
            self.currentIndex++;
        }
        //设置播放信息
        [self setMusicInfoWithIndex:self.currentIndex];
    }

    
}
//喜欢的按钮
-(void)likeBtnAction{
    if (!self.likeState) {
        
        [self.likeBtn setImage:self.likedImage forState:UIControlStateNormal ];
        //初始化弹窗
        MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
        [message showAlertWith:@"❤️\n已添加到我喜欢的音乐"];
    }else{
        [self.likeBtn setImage:self.likeImage forState:UIControlStateNormal];
        //初始化弹窗
        MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
        [message showAlertWith:@"\n  已取消喜欢  \n"];
        
    }
    self.likeState = !self.likeState;
}

//下载的按钮
-(void)downloadBtnAction{
    
    //先检测网络
    if (!self.networkInformationError) {
        
        
        //检测音乐文件存不存在
        if (![[NSFileManager defaultManager]fileExistsAtPath:self.musicDownloadString]) {
            //判断是否同一下载
            if (self.isDownloadingUrlString != self.mp3Url) {
                
                //弹窗显示
                MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
                [message showAlertWith:@"⬇️\n已加入下载队列\n"];
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    //创建一个下载
                    Dowload *dowload = [[Dowload alloc]initWithUrl:self.mp3Url];
                    //开启
                    [dowload startDownload];
                    self.isDownloadingUrlString = self.mp3Url;
                    
                    [dowload downloading:^(long long bytesWritten, float progress) {
                        
                        NSLog(@"%f%%", progress);
                        
                    } didFinished:^(NSString *filepath, NSString *url) {
                        
                        NSLog(@"%@", filepath);
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            //下载完成后更新下载按钮
                            [self.downloadBtn setImage:self.downloadOkImage forState:UIControlStateNormal];
                            
                        });
                        
                    }];
                    
                });
                
            }else{
                //初始化弹窗
                MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
                [message showAlertWith:@"请稍后\n 正在下载中 "];
            }
            
            
            
        }else{
            
            //初始化弹窗
            MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
            [message showAlertWith:@"\n   亲,已下载   \n"];
            
        }
        
        
        
        
    }else{
        //初始化弹窗
        MBFadeAlertView *message =[[MBFadeAlertView alloc]init];
        [message showAlertWith:@"\n   亲,没有网哎   \n"];
    }
    

    
    
}
//评论的按钮
-(void)commentsBtnAction{

}
//更多按钮
-(void)moreBtnAction{
    
}
//
-(void)fingerIncident{
    
    if (!self.gesturesState) {
        
        [self.view insertSubview:self.cdScrollView atIndex:0];
        [self.view insertSubview:self.needleImageView atIndex:0];
        [self.view insertSubview:self.cdBackground atIndex:0];
        [self.view insertSubview:self.downloadBtn atIndex:0];
        [self.view insertSubview:self.likeBtn atIndex:0];
        [self.view insertSubview:self.commentsBtn atIndex:0];
        [self.view insertSubview:self.moreBtn atIndex:0];
        
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.theVolumeSlider];
        [self.view addSubview:self.volumeImage];
        [self.view addSubview:self.AirPlayImage];
        //增加事件者响应者，
        [self.tableView addGestureRecognizer:self.singleFingerOne];
        
    }else{
        
        [self.visualeffectview addSubview:self.cdBackground ];

    
        [self.view addSubview:self.likeBtn];
        [self.view addSubview:self.downloadBtn];
        [self.view addSubview:self.commentsBtn];
        [self.view addSubview:self.moreBtn];
        [self.cdAndneedleBackground addSubview:self.cdScrollView];
        [self.cdAndneedleBackground addSubview:self.needleImageView];
        
        [self.view insertSubview:self.tableView atIndex:0];
        [self.view insertSubview:self.theVolumeSlider atIndex:0];
        [self.view insertSubview:self.volumeImage atIndex:0];
        [self.view insertSubview:self.AirPlayImage atIndex:0];
        //增加事件者响应者，
        [self.cdScrollView addGestureRecognizer:self.singleFingerOne];
    }
    self.gesturesState = !self.gesturesState;
}
//分享按钮
-(void)rightBarButtonAction{
    
}
//循环方式按钮
-(void)circulationAction{
    
}
//歌曲列表按钮
-(void)musicListAction{
    
}
//音量调节
-(void)theVolumeSliderAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

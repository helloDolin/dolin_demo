//
//  Dolin2ViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin2ViewController.h"
#import "ExpandClickAreaButton.h"
#import "RequestManager.h"
#import "MusicListCell.h"
#import "PlayMusicViewController.h"
#import "UINavigationBar+Awesome.h"

// TODO：
// 1.table header 完善
// 2.section header 完善


@interface Dolin2ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong ) UITableView        *tableView;

@property (nonatomic,strong  ) NSString           *playListUrl;

@property (nonatomic,strong  ) UIImageView        *tableViewBackgroundImage;// 背景照片

@property (nonatomic,strong  ) UIImageView        *theCoverImage;// 封面照片

@property (nonatomic,strong  ) UILabel            *theCoverTitle;// 封面标题

@property (nonatomic,strong  ) NSString           *musicListCount;// 歌曲总数



@end

// 可以定义多个匿名类别，扩展
@interface Dolin2ViewController ()

@property (nonatomic , strong) UIBlurEffect       *blureffect;// 毛玻璃

@property (nonatomic , strong) UIVisualEffectView *visualeffectview;// 毛玻璃

@property (nonatomic,strong  ) CATransition       *transition;// 延时动画

@end

@implementation Dolin2ViewController

#pragma mark - init
+ (instancetype)sharedDolin2ViewController {
    static Dolin2ViewController *handle =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[Dolin2ViewController alloc]init];
    });
    return handle;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self setLeftBarBtn];
    [self setRightBarBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.shadowImage = nil;
}

#pragma mark -  左右两个bar item 点击事件

- (void)leftBtnAction {
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"更换id" message:@"可通过分享歌单获得" preferredStyle:UIAlertControllerStyleAlert];

    [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"输入网易云id";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField* textField = alertVC.textFields[0];
        NSString* musicID = textField.text;
        if (musicID.length !=9) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的id号"];
            return;
        }
        NSRange range = [kUrl rangeOfString:@"id"];
        NSString* str = [kUrl substringToIndex:range.location];
        self.playListUrl = [NSString stringWithFormat:@"%@id=%@",str,musicID];
        [self updateAction];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setRightBarBtn {
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新歌单" style:UIBarButtonItemStylePlain target:self action:@selector(updateAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setLeftBarBtn {
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithTitle:@"更换id" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}



#pragma mark - public method 

- (void)layoutUI {
    //毛玻璃
    self.blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //添加毛玻璃view视图
    self.visualeffectview = [[UIVisualEffectView alloc]initWithEffect:self.blureffect];
    //设置毛玻璃的view视图的大小
    self.visualeffectview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.383f);
    
    //背景照片
    self.tableViewBackgroundImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.383f)];
    [self.tableViewBackgroundImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.tableViewBackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.tableViewBackgroundImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableViewBackgroundImage.clipsToBounds = YES;
    self.tableViewBackgroundImage.backgroundColor =[UIColor clearColor];
    
    self.transition = [CATransition animation];
    self.transition.duration = 2.0f;
    self.transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.transition.type = kCATransitionFade;
    
    
    [self.view insertSubview:self.tableViewBackgroundImage atIndex:0];
    [self.view insertSubview:self.visualeffectview atIndex:1];
    [self.view addSubview:self.tableView];
}

-(void)updateAction {
    [SVProgressHUD show];
    [[RequestManager sharedManager]fetchDataWithUrl:self.playListUrl updateUI:^{
        [SVProgressHUD dismiss];
        Music *music =[[RequestManager sharedManager]returnMusicAtIndex:0];
        self.theCoverTitle.text = music.listName;
        [self.tableViewBackgroundImage sd_setImageWithURL:[NSURL URLWithString:music.listTheCoverUrl]];
        //动画
        [self.tableViewBackgroundImage.layer addAnimation:self.transition forKey:nil];
        [self.theCoverImage sd_setImageWithURL:[NSURL URLWithString:music.listTheCoverUrl]];
        //动画
        [self.theCoverImage.layer addAnimation:self.transition forKey:nil];
        self.musicListCount = music.musicListCount;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[RequestManager sharedManager]returnArrayCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"MusicListCell"];
    Music *music = [[RequestManager sharedManager]returnMusicAtIndex:indexPath.row];
    [cell setCellWithMusic:music];
    cell.number.text =  [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight*0.0724f;  // 这种适配方式也不错嘛 😆
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayMusicViewController *playVc = [PlayMusicViewController sharedManager];
    playVc.index = indexPath.row;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playVc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < 0) {
        self.tableViewBackgroundImage.frame  = CGRectMake(offSetY/2, 0, kWidth +(-offSetY), (kHeight*0.383f)+(-offSetY));
        self.visualeffectview.frame  =CGRectMake(offSetY/2, 0, kWidth +(-offSetY), (kHeight*0.383f)+(-offSetY));
    }
}

#pragma mark - getter
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:FULL_SCREEN_FRAME style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"MusicListCell" bundle:nil] forCellReuseIdentifier:@"MusicListCell"];
        
        UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.2975f)];
        headerView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headerView;
        
        // 封面
        self.theCoverImage =[[UIImageView alloc]initWithFrame:CGRectMake(kHeight *0.0199f, kHeight*0.0176f, kHeight *0.19f, kHeight *0.19f)];
        [headerView addSubview:self.theCoverImage];
        
        // 封面标题
        self.theCoverTitle =[[UILabel alloc]initWithFrame:CGRectMake(kHeight *0.2296f, kHeight *0.039f, kHeight *0.2948f, kHeight *0.0634f)];
        self.theCoverTitle.numberOfLines = 0;
        self.theCoverTitle.font =[UIFont systemFontOfSize:18];
        self.theCoverTitle.textColor =[UIColor whiteColor];
        [headerView addSubview:self.theCoverTitle];
        
        
//        设置扩展按钮，指定角为圆角
//        ExpandClickAreaButton* btn = [ExpandClickAreaButton buttonWithType:UIButtonTypeSystem];
//        btn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
//        btn.frame = CGRectMake(0 , kHeight *0.183f, SCREEN_WIDTH, kHeight *0.12f);
//        [btn setImage:[[UIImage imageNamed:@"btn_like"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = btn.bounds;
//        maskLayer.path = maskPath.CGPath;
//        btn.layer.mask = maskLayer;
//        [headerView addSubview:btn];


    }
    return _tableView;
}

@end

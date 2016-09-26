//
//  Dolin3ViewController.m
//  dolin_demo
//
//  Created by dolin on 16/8/30.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "Dolin3ViewController.h"
#import "CameraViewController.h"
#import "LLBootstrap.h"
#import "SheViewController.h"
#import "UIView+ZKPulseView.h"

@interface Dolin3ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

// 原生扫描用到的几个类
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@end

@implementation Dolin3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self layOutUI];
}

- (void)layOutUI {
    UIButton *jumpCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpCameraBtn setTitle:@"CameraViewController" forState:UIControlStateNormal];
    [jumpCameraBtn bs_configureAsDefaultStyle];
    
    [jumpCameraBtn addTarget:self action:@selector(jumpCameraBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [jumpCameraBtn startPulseWithColor:[UIColor convertHexToRGB:@"C1FFC1"]];
    

    UIButton *jumpLoveGirlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpLoveGirlBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [jumpLoveGirlBtn addTarget:self action:@selector(jumpLoveGirlBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [jumpLoveGirlBtn bs_configureAsPrimaryStyle];
    [jumpLoveGirlBtn startPulseWithColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:jumpCameraBtn];
    [self.view addSubview:jumpLoveGirlBtn];
    
    [jumpCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 + 10);
        make.left.equalTo(self.view).offset(10);
        make.height.equalTo(@80);
        make.right.equalTo(self.view.mas_centerX).offset(-10);
    }];
    
    [jumpLoveGirlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 + 10);
        make.left.equalTo(self.view.mas_centerX).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(jumpCameraBtn);
    }];

}

#pragma mark - event
- (void)jumpCameraBtnAction {
    [self.navigationController pushViewController:[CameraViewController new] animated:YES];
}
    
- (void)jumpLoveGirlBtnAction {
    NSLog(@"jumpLoveGirlBtnAction");
    [self setupCamera];
}

#pragma mark - method
- (void)setupCamera {
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session 连接输入和输出
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 添加扫描画面
    dispatch_async(dispatch_get_main_queue(), ^{
        // Preview
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = CGRectMake(20,64 + 80 + 30,SCREEN_WIDTH - 40,280);
        [self.view.layer insertSublayer:self.preview atIndex:0];
        
        // 开始扫描
        [_session startRunning];
    });
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        ALERT(@"%@", stringValue);
//        [self presentViewController:[SheViewController new] animated:YES completion:nil];
    }
    
    // 停止扫描
    [_session stopRunning];
    
}

@end

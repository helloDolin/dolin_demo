//
//  CameraViewController.m
//  dolin_demo
//
//  Created by shaolin on 16/9/4.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  method
- (void)layoutUI {
    UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItemButton addTarget:self action:@selector(rightItemButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightItemButton setImage:[[UIImage imageNamed:@"btn_home_test"] imageWithRenderingMode:UIImageRenderingModeAutomatic] forState:UIControlStateNormal];
    [rightItemButton sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemButtonAction {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"title"                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self isCameraSupportMedia:(__bridge NSString*)kUTTypeImage];
        [self isCameraSupportMedia:(__bridge NSString*)kUTTypeMovie];
        [self configUIImagePiker];
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"视频" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void)configUIImagePiker {
    // 拍照还是取照片
    UIImagePickerController* controller = [[UIImagePickerController alloc]init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    NSString* requireMediaType = (__bridge NSString*)kUTTypeImage;
    controller.mediaTypes = [[NSArray alloc]initWithObjects:requireMediaType, nil];
    controller.allowsEditing = NO; // 是否可编辑
    controller.delegate = self;
    controller.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (void)getPhoto {
    // 1.检测设备时候可用
    // 2.配置UIImagePickerController
    
    //===== 扫面照片库
    ALAssetsLibrary* assetLibrary = [[ALAssetsLibrary alloc]init];
    // 代码放到队列中执行
    // 创建队列
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);// 优先级，参数
    dispatch_async(q, ^{
        NSLog(@"%@",[NSThread currentThread]);
        // 扫描媒体库
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            // 查看资源
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                NSString* assetType = [result valueForProperty:ALAssetPropertyType];
                // 是否是图片
                if ([assetType isEqualToString:assetType]) {
                    *stop = YES ;
                    ALAssetRepresentation* assetRepresentation = [result defaultRepresentation];
                    float scale = [assetRepresentation scale]; // 缩放参数
                    UIImageOrientation orientation = (UIImageOrientation)[assetRepresentation orientation];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGImageRef imageRef = [assetRepresentation fullScreenImage];
                        UIImage* image = [[UIImage alloc]initWithCGImage:imageRef scale:scale orientation:orientation];
                        if (image) {
                            NSLog(@"拿到image");
                        }
                    });
                }
            }];
            
        } failureBlock:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    });
}


// paraMediaType
- (BOOL)isCameraSupportMedia:(NSString*)paraMediaType {
    // 支持的所有媒体类型
    NSArray* validMedias = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    for (NSString* item in validMedias) {
        if ([item isEqualToString:paraMediaType]) {
            return YES;
        }
    }
    return NO;
}

// 检查前后摄像头是否可用
- (BOOL)isCameraValidFront {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)isCameraValidRear {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


/**
 *  检测相机是否可用
 */
- (BOOL)isCameraValid {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  检测 前置摄像头闪光灯是否可用
 */
- (BOOL)isCameraFlashFrontValid {
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
    
}

/**
 *  检测 后置摄像头闪光灯是否可用
 */
- (BOOL)isCameraFlashRearValid {
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark -  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString* mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        UIImage* image = info[UIImagePickerControllerOriginalImage];
        // 将image转为data
        NSData *data = UIImageJPEGRepresentation(image,1.0);
        
        //<#消除警告#>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
#pragma clang diagnostic pop
        
        // info[UIImagePickerControllerMediaMetadata];
        // 可以打印出info 取自己想要的信息
        
        
        // 保存图片到app相册
        SEL saveImage = @selector(imageWasSaveSuccess:didFinishWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(image, self, saveImage, nil);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageWasSaveSuccess:(UIImage*)image
         didFinishWithError:(NSError*)error
                contextInfo:(void*)info {
    if (error == nil) {
        NSLog(@"图片保存成功");
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"error = %@",error);
    }
}

@end

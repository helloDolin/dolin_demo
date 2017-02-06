//
//  SystemPermissionsManager.m
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "SystemPermissionsManager.h"
#import "BlockAlertView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import <CoreLocation/CoreLocation.h>

@interface SystemPermissionsManager() <CLLocationManagerDelegate>

@property(nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation SystemPermissionsManager

#pragma mark - life circle
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置定位 (需要定位服务的时候打开)
        [self setUpLocation];
    }
    return self;
}

#pragma mark - 单例
SINGLETON_FOR_IMPLEMENTATION(SystemPermissionsManager);

#pragma mark - method
+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions {
    SystemPermissionsManager* systemPermissionsManager = [SystemPermissionsManager sharedSystemPermissionsManager];
    return [systemPermissionsManager requestAuthorization:systemPermissions];
}

- (BOOL)requestAuthorization:(SystemPermissions)systemPermissions {
    switch (systemPermissions) {
        case SystemPermissions_AVMediaTypeVideo:
            return [self handleCamera];
            break;
        case SystemPermissions_ALAssetsLibrary:
            return [self handleLibrary];
            break;
        case SystemPermissions_CLLocationManager:
            return [self handleLocation];
            break;
        case SystemPermissions_AVAudioSession:
            return [self handleAudioSession];
            break;
        case SystemPermissions_ABAddressBook:
            return [self handleAddressBook];
            break;

    }
    return YES;
}


/**
 *  处理通讯录
 */
- (BOOL)handleAddressBook {
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-联系人“选项中，允许%@访问你的手机通讯录",APP_NAME];
    
    if (authStatus ==kABAuthorizationStatusDenied) {
        [self executeAlterTips:tips isSupport:YES];
        return NO;
    } else if (authStatus == kABAuthorizationStatusRestricted) {
        [self executeAlterTips:nil isSupport:NO];
        return NO;
    } else if (authStatus == kABAuthorizationStatusNotDetermined) {
        __block ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (addressBook == NULL) {
            [self executeAlterTips:nil isSupport:NO];
            return NO;
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                
            }else{
                
            }
            if (addressBook) {
                CFRelease(addressBook);
                addressBook = NULL;
            }
        });
    } else if (authStatus == kABAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}

- (BOOL)canRecord {
    __block BOOL bCanRecord = YES;
    if ([[UIDevice currentDevice] systemVersion].floatValue > 7.0){
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}

/**
 *  处理音频
 */
- (BOOL)handleAudioSession {
    if (![self canRecord]) {
        NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-麦克风“选项中，允许%@访问你的麦克风",APP_NAME];
        [self executeAlterTips:tips isSupport:YES];
        return NO;
    }
    return YES;
}

/**
 *  处理定位
 */
- (BOOL)handleLocation {
    CLAuthorizationStatus authStatus = CLLocationManager.authorizationStatus;
    if (authStatus == kCLAuthorizationStatusDenied) {
        NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-定位“选项中，允许%@访问你的定位",APP_NAME];
        [self executeAlterTips:tips isSupport:YES];
        return NO;
    } else if(authStatus == kCLAuthorizationStatusRestricted) {
        [self executeAlterTips:nil isSupport:NO];
        return NO;
    }
    // 剩下的情况就是已经授权了
    return YES;
}

/**
 *  处理相册
 */
- (BOOL)handleLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (authStatus == ALAuthorizationStatusDenied) {
                NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问你的手机相册",APP_NAME];
                [self executeAlterTips:tips isSupport:YES];
                return NO;
            } else if (authStatus == ALAuthorizationStatusRestricted) {
                [self executeAlterTips:nil isSupport:NO];
                return NO;
            }
        } else {
            PHAuthorizationStatus  authorizationStatus = [PHPhotoLibrary authorizationStatus];
            if (authorizationStatus == PHAuthorizationStatusRestricted) {
                [self executeAlterTips:nil isSupport:NO];
                return NO;
            } else if(authorizationStatus == PHAuthorizationStatusDenied) {
                NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问你的手机相册",APP_NAME];
                [self executeAlterTips:tips isSupport:YES];
                return NO;
            } else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    
                }];
                return NO;
            } else if (authorizationStatus == PHAuthorizationStatusAuthorized) {
                return YES;
            }

        }
    }
    return NO;
}

/**
 *  处理相机
 */
- (BOOL)handleCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if (authStatus == ALAuthorizationStatusDenied) { // 用户拒绝App使用
                NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机“选项中，允许%@访问你的手机相机",APP_NAME];
                [self executeAlterTips:tips isSupport:YES];
                return NO;
            } else if (authStatus == ALAuthorizationStatusRestricted ){ //未授权，且用户无法更新，如家长控制情况下
                [self executeAlterTips:nil isSupport:NO];
                return NO;
            } else if (authStatus == ALAuthorizationStatusNotDetermined ){ // 未进行授权选择
                // 请求授权
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        
                    } else {
                        
                    }
                }];
                return NO;
            } else if (authStatus == ALAuthorizationStatusAuthorized) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)executeAlterTips:(NSString *)alterTips isSupport:(BOOL)isSupport {
    // 异步处理
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *alterContent = @"";
        if (isSupport) {
            alterContent = alterTips;
            [BlockAlertView alertWithTitle:alterContent message:@"" cancelBtnWithTitle:@"取消" cancelBlock:^{
                
            } confirmButtonWithTitle:@"去设置" confirmBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                                   options:@{@"url":@""}
                                         completionHandler:^(BOOL success) {
                                             
                                         }];
            } ];
        }
        else {
            alterContent = @"权限受限";
            [BlockAlertView alertWithTitle:alterContent message:@"" cancelBtnWithTitle:nil cancelBlock:^{
                
            } confirmButtonWithTitle:@"确定" confirmBlock:^{
                
            }];
        }
    });
}

- (void)setUpLocation {
    //定位
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1.0;
    
    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization]; // 永久授权
    }
    
    //    //开始定位，不断调用其代理方法
    //    [self.locationManager startUpdatingLocation];
    
    if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
            [_locationManager requestAlwaysAuthorization];
        }
        CLAuthorizationStatus status = CLLocationManager.authorizationStatus;
        if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
            
        }else{
            
        }
    }else{
        
    }

}

@end

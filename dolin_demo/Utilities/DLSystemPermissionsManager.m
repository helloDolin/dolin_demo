//
//  SystemPermissionsManager.m
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLSystemPermissionsManager.h"
#import "DLBlockAlertView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>

@interface DLSystemPermissionsManager() <CLLocationManagerDelegate>

@property (nonatomic,copy) SureBtnClickBlock sureBtnClickBlock;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation DLSystemPermissionsManager

#pragma mark - life circle
+ (instancetype)sharedSystemPermissionsManager {
    static DLSystemPermissionsManager* obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[DLSystemPermissionsManager alloc]init];
    });
    return obj;
}

#pragma mark - method
+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions withSureBtnClickBlock:(SureBtnClickBlock)sureBtnClickBlock {
    DLSystemPermissionsManager* systemPermissionsManager = [DLSystemPermissionsManager sharedSystemPermissionsManager];
    systemPermissionsManager.sureBtnClickBlock = sureBtnClickBlock;
    return [systemPermissionsManager requestAuthorization:systemPermissions];
}

+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions {
    return [self requestAuthorization:systemPermissions withSureBtnClickBlock:nil];
}

- (BOOL)requestAuthorization:(SystemPermissions)systemPermissions {
    switch (systemPermissions) {
        case SystemPermissionsCamera:
            return [self handleCamera];
            break;
        case SystemPermissionsPhotoLibrary:
            return [self handlePhotoLibrary];
            break;
        case SystemPermissionsLocation:
            return [self handleLocation];
            break;
        case SystemPermissions_AVAudioSession:
            return [self handleAudioSession];
            break;
        case SystemPermissionsAddressBook:
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
    
    if (authStatus == kABAuthorizationStatusDenied) {
        [self executeAlterTips:tips isSupport:YES];
        return NO;
    }
    else if (authStatus == kABAuthorizationStatusRestricted) {
        [self executeAlterTips:nil isSupport:NO];
        return NO;
    }
    else if (authStatus == kABAuthorizationStatusNotDetermined) {
        __block ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (addressBook == NULL) {
            [self executeAlterTips:nil isSupport:NO];
            return NO;
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (self.sureBtnClickBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        self.sureBtnClickBlock();
                    }
                });
            }
            if (addressBook) {
                CFRelease(addressBook);
                addressBook = NULL;
            }
        });
    }
    else if (authStatus == kABAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}

- (BOOL)canRecord {
    __block BOOL isCanRecord = YES;
    if ([[UIDevice currentDevice] systemVersion].floatValue > 7.0){
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    isCanRecord = YES;
                } else {
                    isCanRecord = NO;
                }
            }];
        }
    }
    return isCanRecord;
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
 *  处理相册（iOS8 以下已忽略）
 */
- (BOOL)handlePhotoLibrary {
    // 先判断相册是否为空
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        PHAuthorizationStatus  authorizationStatus = [PHPhotoLibrary authorizationStatus];
        // 您的应用无权访问照片库，用户无法授予此类权限。
        if (authorizationStatus == PHAuthorizationStatusRestricted) {
            [self executeAlterTips:nil isSupport:NO];
            return NO;
        }
        // 用户已明确拒绝您的应用访问照片库
        else if(authorizationStatus == PHAuthorizationStatusDenied) {
            NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问你的手机相册",APP_NAME];
            [self executeAlterTips:tips isSupport:YES];
            return NO;
        }
        // 照片库访问需要明确的用户权限，但用户尚未授予或拒绝此类权限
        else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
            // 请求授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (self.sureBtnClickBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(status == PHAuthorizationStatusAuthorized){
                            self.sureBtnClickBlock();
                        }
                    });
                }
            }];
            return NO;
        }
        // 用户已明确授予您对照片库的应用访问权限
        else if (authorizationStatus == PHAuthorizationStatusAuthorized) {
            return YES;
        }
    }
    return NO;
}

/**
 *  处理相机
 */
- (BOOL)handleCamera {
    // 先判断相机是否可用 eg：模拟器，或者摄像头坏了
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        // 用户明确拒绝
        if (authStatus == ALAuthorizationStatusDenied) {
            NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机“选项中，允许%@访问你的手机相机",APP_NAME];
            [self executeAlterTips:tips isSupport:YES];
            return NO;
        }
        // 未授权，且用户无法更新，如家长控制情况下
        else if (authStatus == ALAuthorizationStatusRestricted ){
            [self executeAlterTips:nil isSupport:NO];
            return NO;
        }
        // 未进行授权选择
        else if (authStatus == ALAuthorizationStatusNotDetermined ){
            // 请求授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (self.sureBtnClickBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            self.sureBtnClickBlock();
                        }
                    });
                }
            }];
            return NO;
        }
        else if (authStatus == ALAuthorizationStatusAuthorized) {
            return YES;
        }
    }
    return NO;
}


/**
 提示

 @param alterTips 提示内容
 @param isSupport 是否支持点击去设置进行openURL
 */
- (void)executeAlterTips:(NSString *)alterTips isSupport:(BOOL)isSupport {
        NSString *alterContent = @"";
        if (isSupport) {
            alterContent = alterTips;
            [DLBlockAlertView alertWithTitle:alterContent message:@"" cancelBtnWithTitle:@"取消" cancelBlock:^{
                
            } confirmButtonWithTitle:@"去设置" confirmBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                                   options:@{@"url":@""}
                                         completionHandler:^(BOOL success) {
                                             
                                         }];
            } ];
        }
        else {
            alterContent = @"权限受限";
            [DLBlockAlertView alertWithTitle:alterContent message:@"" cancelBtnWithTitle:nil cancelBlock:^{
                
            } confirmButtonWithTitle:@"确定" confirmBlock:^{
                
            }];
        }
}

/**
 *  处理定位
 */
- (BOOL)handleLocation {
    CLAuthorizationStatus authStatus = CLLocationManager.authorizationStatus;
    if (authStatus == kCLAuthorizationStatusDenied ||
        authStatus == kCLAuthorizationStatusRestricted) {
        NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-定位“选项中，允许%@访问你的定位",APP_NAME];
        [self executeAlterTips:tips isSupport:YES];
        return NO;
    }
    else if (authStatus == kCLAuthorizationStatusNotDetermined) {
        // 是否在设备上启用了位置服务
        // BOOL isServicesEnabled = [CLLocationManager locationServicesEnabled];
        [self startGps];
        return NO;
    }
    else if (authStatus == kCLAuthorizationStatusAuthorizedAlways ||
             authStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    }
    return NO;
}

- (void)startGps {
    if (self.locationManager != nil ) {
        [self stopGps];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    if (@available(iOS 8,*)) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            BOOL hasAlwaysKey = [[NSBundle mainBundle]
                                 objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
            BOOL hasWhenInUseKey =
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] !=
            nil;
            if (hasAlwaysKey) {
                [_locationManager requestAlwaysAuthorization];
            } else if (hasWhenInUseKey) {
                [_locationManager requestWhenInUseAuthorization];
            } else {
                // At least one of the keys NSLocationAlwaysUsageDescription or
                // NSLocationWhenInUseUsageDescription MUST be present in the Info.plist
                // file to use location services on iOS 8+.
                NSAssert(hasAlwaysKey || hasWhenInUseKey,
                         @"To use location services in iOS 8+, your Info.plist must "
                         @"provide a value for either "
                         @"NSLocationWhenInUseUsageDescription or "
                         @"NSLocationAlwaysUsageDescription.");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void)stopGps {
    if (self.locationManager) {
        [_locationManager stopUpdatingLocation];
        self.locationManager = nil;
    }
}

#pragma CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            //access permission,first callback this status
        }
        break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [self stopGps];
        }
        break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted: {
            [self stopGps];
        break;
        }
    }
}

@end

//
//  SystemPermissionsManager.h
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 以后扩充

// 联网权限
// 相册权限
// 相机、麦克风权限
// 定位权限
// 推送权限
// 通讯录权限
// 日历、备忘录权限

/**
 *  系统权限
 */
typedef NS_ENUM(NSUInteger, SystemPermissions) {
    /**
     *  相机
     */
    SystemPermissions_AVMediaTypeVideo,
    /**
     *  相册
     */
    SystemPermissions_ALAssetsLibrary,
    /**
     *  定位
     */
    SystemPermissions_CLLocationManager,
    /**
     *  音频
     */
    SystemPermissions_AVAudioSession,
    /**
     *  通讯录
     */
    SystemPermissions_ABAddressBook
};

typedef void(^SureBtnClickBlock)(void);

/**
 系统权限管理
 */
@interface SystemPermissionsManager : NSObject

+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions withSureBtnClickBlock:(SureBtnClickBlock)sureBtnClickBlock;
+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions;

@end

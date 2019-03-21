//
//  SystemPermissionsManager.h
//  dolin_demo
//
//  Created by dolin on 17/2/6.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 权限TODO:
    提醒
    日历
    HeathKit
    
 */

/**
 *  系统权限
 */
typedef NS_ENUM(NSUInteger, SystemPermissions) {
    /**
     *  相机
     */
    SystemPermissionsCamera,
    /**
     *  相册
     */
    SystemPermissionsPhotoLibrary,
    /**
     *  定位
     */
    SystemPermissionsLocation,
    /**
     *  音频
     */
    SystemPermissions_AVAudioSession,
    /**
     *  通讯录
     */
    SystemPermissionsAddressBook
};

typedef void(^SureBtnClickBlock)(void);

/**
 系统权限管理
 */
@interface DLSystemPermissionsManager : NSObject

+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions withSureBtnClickBlock:(SureBtnClickBlock)sureBtnClickBlock;

+ (BOOL)requestAuthorization:(SystemPermissions)systemPermissions;

@end

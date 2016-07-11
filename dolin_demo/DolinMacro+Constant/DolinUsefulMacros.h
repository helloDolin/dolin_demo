//
//  DolinUsefulMacros.h
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#ifndef DolinUsefulMacros_h
#define DolinUsefulMacros_h

#pragma mark - App Frame
// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT_NOT_NAVIGATIONBAR_AND_TABBAR (SCREEN_HEIGHT - 64.0 - 49.0)

#define FULL_SCREEN_FRAME CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT_NOT_NAVIGATIONBAR_AND_TABBAR)

#pragma mark - View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y

#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#pragma mark - 系统控件默认高度
#define StatusBarHeight        (20.f)
#define TopBarHeight           (44.f)
#define BottomBarHeight        (49.f)
#define CellDefaultHeight      (44.f)
#define EnglishKeyboardHeight  (216.f)
#define ChineseKeyboardHeight  (252.f)

#pragma mark - 沙盒路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark - 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


#pragma mark - 颜色(RGB)

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 随机颜色
#define RANDOM_UICOLOR     [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]


#pragma mark - View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#pragma mark - 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])


#pragma mark - 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)


#pragma mark - 时间方面
// 时间间隔
#define kHUDDuration            (1.f)
// 一天的秒数
#define SecondsOfDay            (24.f * 60.f * 60.f)
// 秒数
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))
// 一天的毫秒数
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
// 毫秒数
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))

#pragma mark -  app 信息
#define APP_STORE_URL       @"itms-apps://itunes.apple.com/us/app/xiong-zhao/id1020593660?l=zh&ls=1&mt=8"
#define APP_STORE_INFO_URL  @"https://itunes.apple.com/cn/lookup?id=1020593660"
#define VERSION             [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IOS7_OR_LATER       ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )




#pragma mark -  block self
#define BlockWeakObject(o) __typeof(o) __weak
#define BlockWeakSelf BlockWeakObject(self)



#pragma mark -  Alert
#ifdef DEBUG
#define ALERT(some_thing, ...)    \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:some_thing, ##__VA_ARGS__] preferredStyle:UIAlertControllerStyleAlert];  \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];    \
[alertController addAction:okAction];   \
[self presentViewController:alertController animated:YES completion:nil];
#else
#define ALERT(...)
#endif

#pragma mark -  快速单例

#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_IMPLEMENTATION(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

// trim string
#define TRIM_STRING(_string) (\
(OBJECT_IS_EMPTY(_string) || NO == [_string isKindOfClass:[NSString class]]) ? \
@"" : [_string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] \
)

//  检查空对象
#define OBJECT_IS_EMPTY(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)]  && [(NSArray *)_object count] == 0))
#define OBJECT_ISNOT_EMPTY(_object) (NO == OBJECT_IS_EMPTY(_object))
#define RETURN_WHEN_OBJECT_IS_EMPTY(_object)        if (OBJECT_IS_EMPTY(_object)) { return ;    }
#define RETURN_NIL_WHEN_OBJECT_IS_EMPTY(_object)    if (OBJECT_IS_EMPTY(_object)) { return nil; }
#define RETURN_EMPTY_WHEN_OBJECT_IS_EMPTY(_object)  if (OBJECT_IS_EMPTY(_object)) { return @""; }
#define RETURN_YES_WHEN_OBJECT_IS_EMPTY(_object)    if (OBJECT_IS_EMPTY(_object)) { return YES; }
#define RETURN_NO_WHEN_OBJECT_IS_EMPTY(_object)     if (OBJECT_IS_EMPTY(_object)) { return NO; }
#define RETURN_ZERO_WHEN_OBJECT_IS_EMPTY(_object)   if (OBJECT_IS_EMPTY(_object)) { return 0; }


/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */

#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);


#endif /* DolinUsefulMacros_h */

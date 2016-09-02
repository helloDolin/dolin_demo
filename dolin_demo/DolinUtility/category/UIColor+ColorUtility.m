//
//  UIColor+ColorUtility.m
//  Ule
//
//  Created by eachnet on 11/30/12.
//  Copyright (c) 2012 Ule. All rights reserved.
//

#import "UIColor+ColorUtility.h"

@implementation UIColor (ColorUtility)

/**
 *十六进制转RGB
 */
+(UIColor *)convertHexToRGB:(NSString *)hexString{
    NSString *str;
    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        str=[[NSString alloc] initWithFormat:@"%@",hexString];
    }else {
        str=[[NSString alloc] initWithFormat:@"0x%@",hexString];
    }
    
    long long rgb;
    sscanf([str cStringUsingEncoding:NSUTF8StringEncoding], "%lli", &rgb);
#if ! __has_feature(objc_arc)
    [str release];
#endif
    NSInteger red=rgb/(256*256)%256;
    NSInteger green=rgb/256%256;
    NSInteger blue=rgb%256;
    UIColor *color=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}


@end

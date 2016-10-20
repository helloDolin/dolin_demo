//
//  NSObject+DLRuntime.m
//  dolin_demo
//
//  Created by dolin on 16/10/20.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "NSObject+DLRuntime.h"

@implementation NSObject (DLRuntime)

+ (void)logPropertyByDic:(NSDictionary*)dic {
    NSMutableString* mutableStr = [NSMutableString string];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString* type;
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSArrayI")]){
            type = @"NSArray";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"int";
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }
        
        NSString* varStr;
        
        if ([type containsString:@"NS"]) {
            varStr = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        } else {
            varStr = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        
        [mutableStr appendFormat:@"\n%@\n",varStr];
    }];
    
    NSLog(@"%@",mutableStr);
}

+ (void)logPropertyByJSONStr:(NSString*)jsonStr {
    
}


@end

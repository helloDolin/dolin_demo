//
//  NSString+Version.h
//  AflacSiteSeller
//
//  Created by Craig Spitzkoff on 11/28/10.
//  Copyright 2010 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Version) 

- (BOOL)isOlderVersionThan:(NSString*)otherVersion;
- (BOOL)isNewerVersionThan:(NSString*)otherVersion;

@end


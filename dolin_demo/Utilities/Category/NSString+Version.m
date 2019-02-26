//
//  NSString+Version.m
//  AflacSiteSeller
//
//  Created by Craig Spitzkoff on 11/28/10.
//  Copyright 2010 Raizlabs. All rights reserved.
//

#import "NSString+Version.h"


@implementation NSString(Version)

- (BOOL)isOlderVersionThan:(NSString*)otherVersion
{
	return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}

- (BOOL)isNewerVersionThan:(NSString*)otherVersion
{
	return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);	
}

@end

//
//  Smoke+CoreDataProperties.m
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Smoke+CoreDataProperties.h"

@implementation Smoke (CoreDataProperties)

+ (NSFetchRequest<Smoke *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Smoke"];
}

@dynamic date;
@dynamic count;

@end

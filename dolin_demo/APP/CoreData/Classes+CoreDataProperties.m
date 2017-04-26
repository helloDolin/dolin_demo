//
//  Classes+CoreDataProperties.m
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Classes+CoreDataProperties.h"

@implementation Classes (CoreDataProperties)

+ (NSFetchRequest<Classes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Classes"];
}

@dynamic c_id;
@dynamic c_name;
@dynamic c_stu;

@end

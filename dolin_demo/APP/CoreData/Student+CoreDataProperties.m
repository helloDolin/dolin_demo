//
//  Student+CoreDataProperties.m
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic s_name;
@dynamic s_id;
@dynamic s_calss;

@end

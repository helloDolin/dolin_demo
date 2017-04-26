//
//  Student+CoreDataProperties.h
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *s_name;
@property (nonatomic) int64_t s_id;
@property (nullable, nonatomic, retain) Classes *s_calss;

@end

NS_ASSUME_NONNULL_END

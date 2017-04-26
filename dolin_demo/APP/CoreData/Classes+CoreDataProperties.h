//
//  Classes+CoreDataProperties.h
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Classes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Classes (CoreDataProperties)

+ (NSFetchRequest<Classes *> *)fetchRequest;

@property (nonatomic) int64_t c_id;
@property (nullable, nonatomic, copy) NSString *c_name;
@property (nullable, nonatomic, retain) NSSet<Student *> *c_stu;

@end

@interface Classes (CoreDataGeneratedAccessors)

- (void)addC_stuObject:(Student *)value;
- (void)removeC_stuObject:(Student *)value;
- (void)addC_stu:(NSSet<Student *> *)values;
- (void)removeC_stu:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END

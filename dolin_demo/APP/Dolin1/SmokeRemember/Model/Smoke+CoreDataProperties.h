//
//  Smoke+CoreDataProperties.h
//  
//
//  Created by dolin on 2017/4/26.
//
//

#import "Smoke+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Smoke (CoreDataProperties)

+ (NSFetchRequest<Smoke *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) int64_t count;

@end

NS_ASSUME_NONNULL_END

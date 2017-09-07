//
//  NSManagedObjectContext+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 11.06.16.
//  Copyright © 2016 Anobisoft.com. All rights reserved.
//

#import "NSManagedObjectContext+AnobiKit.h"

@implementation NSManagedObjectContext (AnobiKit)


- (NSManagedObject *)insertTo:(NSString *)entityName {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}

- (NSArray *)selectFrom:(NSString *)e {
    return [self selectFrom:e limit:0];
}

- (NSArray *)selectFrom:(NSString *)e limit:(NSUInteger)l {
    return [self selectFrom:e orderBy:nil limit:l];
}

- (NSArray *)selectFrom:(NSString *)e orderBy:(nullable NSArray <NSSortDescriptor *> *)sds {
    return [self selectFrom:e orderBy:sds limit:0];
}

- (NSArray *)selectFrom:(NSString *)e orderBy:(nullable NSArray <NSSortDescriptor *> *)sds limit:(NSUInteger)l {
    return [self selectFrom:e where:nil orderBy:sds limit:l];
}

- (NSArray *)selectFrom:(NSString *)e where:(NSPredicate *)c {
    return [self selectFrom:e where:c limit:0];
}

- (NSArray *)selectFrom:(NSString *)e where:(NSPredicate *)c limit:(NSUInteger)l {
    return [self selectFrom:e where:c orderBy:nil limit:l];
}

- (NSArray *)selectFrom:(NSString *)e where:(NSPredicate *)c orderBy:(nullable NSArray <NSSortDescriptor *> *)sds {
    return [self selectFrom:e where:c orderBy:sds limit:0];
}

- (NSArray *)selectFrom:(NSString *)entity
                  where:(NSPredicate *)clause
                orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors
                  limit:(NSUInteger)limit {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entity];
    request.predicate = clause;
    [request setSortDescriptors:sortDescriptors];
    [request setFetchLimit:limit];
    NSError *error = nil;
    NSArray *entities = [self executeFetchRequest:request error:&error];
    if (error) NSLog(@"[ERROR] %s %@\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error.userInfo);
    return entities;
}

@end

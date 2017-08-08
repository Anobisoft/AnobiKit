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

- (NSArray *)selectFrom:(NSString *)entity {
    return [self selectFrom:entity limit:0];
}

- (NSArray *)selectFrom:(NSString *)entity limit:(NSUInteger)limit {
    return [self selectFrom:entity orderBy:nil limit:limit];
}

- (NSArray *)selectFrom:(NSString *)entity orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors {
    return [self selectFrom:entity orderBy:sortDescriptors limit:0];
}

- (NSArray *)selectFrom:(NSString *)entity orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit {
    return [self selectFrom:entity where:nil orderBy:sortDescriptors limit:limit];
}

- (NSArray *)selectFrom:(NSString *)entity where:(NSPredicate *)clause {
    return [self selectFrom:entity where:clause limit:0];
}

- (NSArray *)selectFrom:(NSString *)entity where:(NSPredicate *)clause limit:(NSUInteger)limit {
    return [self selectFrom:entity where:clause orderBy:nil limit:limit];
}

- (NSArray *)selectFrom:(NSString *)entity where:(NSPredicate *)clause orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors {
    return [self selectFrom:entity where:clause orderBy:sortDescriptors limit:0];
}

- (NSArray *)selectFrom:(NSString *)entity where:(NSPredicate *)clause orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit {
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

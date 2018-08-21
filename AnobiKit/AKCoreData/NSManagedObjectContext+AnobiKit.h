//
//  NSManagedObjectContext+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 11.06.16.
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObjectContext (AnobiKit)

- (NSManagedObject *)insertTo:(NSString *)entityName;

- (NSArray *)selectFrom:(NSString *)entityName;
- (NSArray *)selectFrom:(NSString *)entityName limit:(NSUInteger)limit;
- (NSArray *)selectFrom:(NSString *)entityName
                orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors;
- (NSArray *)selectFrom:(NSString *)entityName
                orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit;

- (NSArray *)selectFrom:(NSString *)entityName
                  where:(nullable NSPredicate *)clause;
- (NSArray *)selectFrom:(NSString *)entityName
                  where:(nullable NSPredicate *)clause limit:(NSUInteger)limit;
- (NSArray *)selectFrom:(NSString *)entityName
                  where:(nullable NSPredicate *)clause
                orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors;
- (NSArray *)selectFrom:(NSString *)entityName
                  where:(nullable NSPredicate *)clause
                orderBy:(nullable NSArray <NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit;

@end

NS_ASSUME_NONNULL_END
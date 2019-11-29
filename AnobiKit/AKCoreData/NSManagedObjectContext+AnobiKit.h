//
//  NSManagedObjectContext+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-06-11.
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObjectContext (SQLStyle)

- (NSManagedObject *)insertTo:(NSString *)entityName;

- (NSArray *)selectFrom:(NSString *)entityName;
- (NSArray *)selectFrom:(NSString *)entityName limit:(NSUInteger)limit;
- (NSArray *)selectFrom:(NSString *)entityName orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors;
- (NSArray *)selectFrom:(NSString *)entityName orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit;

- (NSArray *)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause;
- (NSArray *)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause limit:(NSUInteger)limit;
- (NSArray *)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors;
- (NSArray *)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit;

@end

typedef void(^FetchOneHandler)(__kindof NSManagedObject *);
typedef void(^FetchArrayHandler)(NSArray<__kindof NSManagedObject *> *);

@interface NSManagedObjectContext (Fetch)

- (void)insertTo:(NSString *)entityName fetch:(FetchOneHandler)fetch;

- (void)selectFrom:(NSString *)entityName
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName limit:(NSUInteger)limit
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause limit:(NSUInteger)limit
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors
             fetch:(FetchArrayHandler)fetch;
- (void)selectFrom:(NSString *)entityName where:(nullable NSPredicate *)clause orderBy:(nullable NSArray<NSSortDescriptor *> *)sortDescriptors limit:(NSUInteger)limit
             fetch:(FetchArrayHandler)fetch;

@end

NS_ASSUME_NONNULL_END

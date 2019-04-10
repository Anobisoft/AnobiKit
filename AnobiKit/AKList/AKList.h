//
//  AKList.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKListItem <NSObject>

@property (nonatomic, readonly, nullable) id object;
@property (nonatomic, strong, nullable) id<AKListItem> next;
@property (nonatomic, strong, nullable) id<AKListItem> prev;

+ (instancetype):(id)object;

@end

#pragma mark -

@interface AKList<__covariant ObjectType> : NSObject

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSUInteger strictlyCount; // cleanup call

+ (instancetype)new;  // retained items
+ (instancetype)weak;  // weak items
/** @throws ProtocolException */
+ (instancetype)listWithItemClass:(Class<AKListItem>)itemClass; // custom items

/** @throws ProtocolException */
- (void)addObject:(ObjectType)object;
/** @throws ProtocolException */
- (void)addItem:(id<AKListItem>)item; // for custom

/** @throws IllegalArgumentException */
- (void)enumerateWithBlock:(void (^)(ObjectType object))block;
- (void)enumerateWithBreakableBlock:(BOOL (^)(ObjectType object))breakableBlock;
- (void)enumerateItemsWithBlock:(void (^)(id<AKListItem> item))block;
- (void)enumerateItemsWithBreakableBlock:(BOOL (^)(id<AKListItem> item))breakableBlock;

- (void)removeItem:(id<AKListItem>)item;
- (void)clear; // release all items
- (void)cleanup; // to collapse unused items

@end

#pragma mark -

@interface AKListAbstractItem<__covariant ObjectType> : NSObject <AKListItem>

@property (nonatomic, readonly) ObjectType object; // override!

/** Instantiation method
 @throws InstantiationException, AbstractMethodException
 */
+ (instancetype):(ObjectType)object;

/** @throws AbstractMethodException */
- (instancetype)initWithObject:(ObjectType)object;

@end

#pragma mark -

@interface AKListItem : AKListAbstractItem <NSCopying, NSMutableCopying>

@end

@interface AKListMutableItem<__covariant ObjectType> : AKListItem

@property (nonatomic, readwrite) ObjectType object;

@end

#pragma mark -

@interface AKListWeakItem : AKListAbstractItem <NSCopying, NSMutableCopying>

@end

@interface AKListMutableWeakItem<__covariant ObjectType> : AKListWeakItem

@property (nonatomic, readwrite) ObjectType object;

@end

NS_ASSUME_NONNULL_END

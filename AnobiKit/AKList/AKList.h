//
//  AKList.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKListItem <NSObject>

@property (nonatomic, readonly, nullable) id object;
@property (nonatomic, strong, nullable) id<AKListItem> next;
@property (nonatomic, strong, nullable) id<AKListItem> prev;

+ (instancetype):(id)object;

@end


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
- (void)enumerateItemsWithBlock:(void (^)(id<AKListItem> item))block;

- (void)removeItem:(id<AKListItem>)item;
- (void)clear; // release all items
- (void)cleanup; // to collapse unused items

@end

NS_ASSUME_NONNULL_END

//
//  AKList.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKListItem.h>
#import <AnobiKit/AKListItemBox.h>
#import <AnobiKit/AKListItemWeakBox.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKList<__covariant ObjectType> : NSObject

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSUInteger strictlyCount; // enumerate call

+ (instancetype)new;  // srtong boxed items
+ (instancetype)weak;  // weak boxed items
+ (instancetype)listWithItemClass:(Class<AKListItem>)class; // custom boxed

- (void)enumerateWithBlock:(void (^)(ObjectType object))block;
- (void)addObject:(ObjectType)object; // strong box as default (AKListItemBox)

- (void)addItem:(id<AKListItem>)item; // for custom
- (void)removeItem:(id<AKListItem>)item;

- (void)clear;

@end

NS_ASSUME_NONNULL_END

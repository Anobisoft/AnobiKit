//
//  AKWeakList.h
//  AKSyncData
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKWeakList<__covariant ObjectType> : NSObject

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSUInteger strictlyCount; // enumerate call

- (void)enumerateWithBlock:(void (^)(ObjectType object))block;
- (void)addObject:(ObjectType)object;
- (void)clear;

@end

NS_ASSUME_NONNULL_END

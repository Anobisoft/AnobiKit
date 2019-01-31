//
//  AKWeakList.h
//  SKManager
//
//  Created by Stanislav Pletnev on 31/01/2019.
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

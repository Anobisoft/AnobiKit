//
//  AKObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKDeepCopying
- (instancetype)deepcopy;
@end

@interface NSDictionary(AKDeepCopying) <AKDeepCopying>
@end
@interface NSArray(AKDeepCopying) <AKDeepCopying>
@end
@interface NSSet(AKDeepCopying) <AKDeepCopying>
@end

@interface AKObject : NSObject <NSSecureCoding, AKDeepCopying>

+ (NSArray<NSString *> *)propertyExclusions;
+ (NSArray<NSString *> *)serializableProperties;
- (NSArray<NSString *> *)serializableProperties;

- (BOOL)mergeToObject:(AKObject *)obj;
- (BOOL)mergeFromObject:(AKObject *)obj;
- (BOOL)isEmpty;

@end

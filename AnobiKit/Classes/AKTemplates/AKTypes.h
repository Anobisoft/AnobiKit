//
//  AKTypes.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 03.02.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#ifndef AKTypes_h
#define AKTypes_h

#import "AKObject.h"
#import "AKSingleton.h"

@protocol Abstract <NSObject>

+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;

@end

@protocol DisableStdInstantiating <NSObject>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@protocol KeyedSubscript <NSObject>
- (id)objectForKeyedSubscript:(NSString *)key;
@end

@protocol IndexedSubscript <NSObject>
- (UIColor *)objectAtIndexedSubscript:(NSUInteger)idx;
@end

typedef void (^AKProcedure)(id object);
typedef void (^AKBlock)(void);
typedef id (^AKFunction)(id object);

#endif /* AKTypes_h */

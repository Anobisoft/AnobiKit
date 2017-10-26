//
//  AKTypes.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 03.02.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#ifndef AKTypes_h
#define AKTypes_h

typedef void (^AKProcedure)(id);
typedef void (^AKBlock)(void);
typedef id (^AKFunction)(id);

#import "AKObject.h"
#import "AKSingleton.h"

@protocol Abstract <NSObject>

+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;

@end

@protocol DisableNSInit <NSObject>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@protocol KeyedSubscript <NSObject>
- (__kindof NSObject *)objectForKeyedSubscript:(__kindof NSObject<NSCopying> *)key;
@end

@protocol IndexedSubscript <NSObject>
- (__kindof NSObject *)objectAtIndexedSubscript:(NSUInteger)idx;
@end

@protocol MutableKeyedSubscript <KeyedSubscript>
- (void)setObject:(__kindof NSObject *)obj forKeyedSubscript:(__kindof NSObject<NSCopying> *)key;
@end

@protocol MutableIndexedSubscript <IndexedSubscript>
- (void)setObject:(__kindof NSObject *)obj forIndexedSubscript:(NSUInteger)idx;
@end



#endif /* AKTypes_h */

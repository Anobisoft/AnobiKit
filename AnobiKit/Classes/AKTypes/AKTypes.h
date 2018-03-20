//
//  AKTypes.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 03.02.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKCodableObject.h>
#import <AnobiKit/AKSingleton.h>

#ifndef AKTypes_h
#define AKTypes_h

@protocol Abstract

+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;

@end

@protocol DisableNSInit

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@protocol KeyedSubscript
- (__kindof NSObject *)objectForKeyedSubscript:(__kindof NSObject<NSCopying> *)key;
@end

@protocol IndexedSubscript
- (__kindof NSObject *)objectAtIndexedSubscript:(NSUInteger)idx;
@end

@protocol MutableKeyedSubscript <KeyedSubscript>
- (void)setObject:(__kindof NSObject *)obj forKeyedSubscript:(__kindof NSObject<NSCopying> *)key;
@end

@protocol MutableIndexedSubscript <IndexedSubscript>
- (void)setObject:(__kindof NSObject *)obj atIndexedSubscript:(NSUInteger)idx;
@end

#endif /* AKTypes_h */

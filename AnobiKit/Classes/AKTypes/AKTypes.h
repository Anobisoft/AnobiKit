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
- (id)objectForKeyedSubscript:(id)key;
@end

@protocol IndexedSubscript
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
@end

@protocol MutableKeyedSubscript <KeyedSubscript>
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;
@end

@protocol MutableIndexedSubscript <IndexedSubscript>
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
@end

#endif /* AKTypes_h */

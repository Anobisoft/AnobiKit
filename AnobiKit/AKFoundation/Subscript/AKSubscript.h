//
//  AKSubscript.h
//  Pods
//
//  Created by Stanislav Pletnev on 18/03/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#ifndef AKSubscript_h
#define AKSubscript_h

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

#endif /* AKSubscript */

#import <AnobiKit/NSMapTable+KeyedSubscript.h>
#import <AnobiKit/NSPointerArray+IndexedSubscript.h>

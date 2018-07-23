//
//  AKInterfaces.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 03.02.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#ifndef AKInterfaces_h
#define AKInterfaces_h

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

#endif /* AKInterfaces_h */

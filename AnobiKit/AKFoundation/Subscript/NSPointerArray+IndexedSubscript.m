//
//  NSPointerArray+IndexedSubscript.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-03-18.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSPointerArray+IndexedSubscript.h"

@implementation NSPointerArray (IndexedSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self pointerAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx == self.count) {
        [self addPointer:(__bridge void * _Nullable)(obj)];
        return;
    }
    [self replacePointerAtIndex:idx withPointer:(__bridge void * _Nullable)(obj)];
}

@end

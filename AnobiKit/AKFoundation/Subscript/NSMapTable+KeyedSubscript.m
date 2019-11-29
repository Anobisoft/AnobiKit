//
//  NSMapTable+KeyedSubscript.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-03-18.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSMapTable+KeyedSubscript.h"

@implementation NSMapTable (KeyedSubscript)

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj) {
        [self setObject:obj forKey:key];
    } else {
        [self removeObjectForKey:key];
    }
}
    

@end

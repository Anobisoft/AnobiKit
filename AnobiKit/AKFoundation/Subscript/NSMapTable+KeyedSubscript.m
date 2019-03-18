//
//  NSMapTable+KeyedSubscript.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 18/03/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSMapTable+KeyedSubscript.h"

@implementation NSMapTable (KeyedSubscript)

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:obj forKey:key];
}

@end

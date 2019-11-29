//
//  NSCache+KeyedSubscript.m
//  Pods
//
//  Created by Stanislav Pletnev on 2019-11-29.
//

#import "NSCache+KeyedSubscript.h"

@implementation NSCache (KeyedSubscript)

- (nullable)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(nullable)obj forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:obj forKey:key];
}

@end

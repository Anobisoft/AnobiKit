//
//  NSString+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 17.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSString+AnobiKit.h"

@implementation NSString (AnobiKit)

- (NSString *)stringByTrimmingSuffix:(NSString *)suffix {
    if ([self hasSuffix:suffix]) {
        return [[self substringToIndex:self.length-suffix.length] stringByTrimmingSuffix:suffix];
    } else {
        return self;
    }
}

- (NSString *)stringByTrimmingPrefix:(NSString *)prefix {
    if ([self hasPrefix:prefix]) {
        return [[self substringFromIndex:prefix.length] stringByTrimmingPrefix:prefix];
    } else {
        return self;
    }
}

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    
    for (; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    
    for (; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

@end

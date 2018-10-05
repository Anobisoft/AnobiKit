//
//  NSDateFormatter+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSDateFormatter+AnobiKit.h"

@implementation NSDateFormatter (AnobiKit)

+ (instancetype)defaultFormatter {
    static id _defaultFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultFormatter = [NSDateFormatter new];
    });
    return _defaultFormatter;
}

@end

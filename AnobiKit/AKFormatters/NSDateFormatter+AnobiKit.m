//
//  NSDateFormatter+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-24.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSDateFormatter+AnobiKit.h"

@implementation NSDateFormatter (AnobiKit)

+ (instancetype)defaultFormatter {
    static id _defaultFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultFormatter = [self new];
    });
    return _defaultFormatter;
}

@end

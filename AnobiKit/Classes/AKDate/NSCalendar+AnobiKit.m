//
//  NSCalendar+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSCalendar+AnobiKit.h"

@implementation NSCalendar (AnobiKit)

+ (instancetype)defaultCalendar {
    static id defaultCalendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCalendar = [self currentCalendar];
    });
    return defaultCalendar;
}

@end

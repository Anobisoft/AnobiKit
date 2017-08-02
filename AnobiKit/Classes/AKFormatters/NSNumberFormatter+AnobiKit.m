//
//  NSNumberFormatter+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 27.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSNumberFormatter+AnobiKit.h"

@implementation NSNumberFormatter (AnobiKit)

+ (instancetype)defaultFormatter {
    static id defaultFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultFormatter = [NSNumberFormatter new];
    });
    return defaultFormatter;
}

- (NSString *)currencyStyleStringFromNumber:(NSNumber *)num currencyCode:(NSString *)cc {
    self.numberStyle = NSNumberFormatterCurrencyStyle;
    if (cc) self.currencyCode = cc;
    else self.currencySymbol = @"";
    return [self stringFromNumber:num];
}

- (NSString *)currencyStyleStringFromNumber:(NSNumber *)num currencyCode:(NSString *)cc precision:(NSUInteger)p {
    self.maximumFractionDigits = p;
    return [self currencyStyleStringFromNumber:num currencyCode:cc];
}

- (NSString *)stringFromNumber:(NSNumber *)num numberStyle:(NSNumberFormatterStyle)nstyle precision:(NSUInteger)p {
    self.maximumFractionDigits = p;
    return [self stringFromNumber:num numberStyle:nstyle];
}

- (NSString *)stringFromNumber:(NSNumber *)num numberStyle:(NSNumberFormatterStyle)nstyle {
    self.numberStyle = nstyle;
    return [self stringFromNumber:num];
}

@end

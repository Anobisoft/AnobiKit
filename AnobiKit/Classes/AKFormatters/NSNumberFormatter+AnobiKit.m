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

+ (instancetype)currencyStyleWithCode:(NSString *)currencyCode {
    static NSMutableDictionary<NSString *, NSNumberFormatter *> *instancesByCurrencyCode;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instancesByCurrencyCode = [NSMutableDictionary new];
    });
    NSNumberFormatter *formatter = instancesByCurrencyCode[currencyCode ?: @""];
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        if (currencyCode) formatter.currencyCode = currencyCode;
        else formatter.currencySymbol = @"";
    }
    return formatter;
}

+ (instancetype)percentStyle {
    static NSNumberFormatter *percentStyleFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        percentStyleFormatter = [NSNumberFormatter new];
        percentStyleFormatter.numberStyle = NSNumberFormatterPercentStyle;
    });
    return percentStyleFormatter;
}

- (NSString *)stringFromNumber:(NSNumber *)number withPrecision:(NSUInteger)p {
    self.maximumFractionDigits = p;
    return [self stringFromNumber:number];
}


@end

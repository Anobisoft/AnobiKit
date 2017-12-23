//
//  NSNumberFormatter+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 27.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSNumberFormatter+AnobiKit.h"

@implementation NSNumberFormatter (AnobiKit)

+ (instancetype)currencyStyleWithCode:(NSString *)currencyCode {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    if (currencyCode) formatter.currencyCode = currencyCode;
    else formatter.currencySymbol = @"";
    return formatter;
}

+ (instancetype)percentStyle {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    return formatter;
}

- (NSString *)stringFromNumber:(NSNumber *)number withPrecision:(NSUInteger)p {
    self.maximumFractionDigits = p;
    return [self stringFromNumber:number];
}


@end

//
//  NSNumberFormatter+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-27.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSNumberFormatter+AnobiKit.h"

@implementation NSNumberFormatter (AnobiKit)

+ (instancetype)currencyStyleWithCode:(NSString *)currencyCode {
    return [[self alloc] initCurrencyStyleWithCode:currencyCode];
}

- (instancetype)initCurrencyStyleWithCode:(NSString *)currencyCode {
    if (self = [self init]) {
        self.numberStyle = NSNumberFormatterCurrencyStyle;
        if (currencyCode) self.currencyCode = currencyCode;
        else self.currencySymbol = @"";
    }
    return self;
}

+ (instancetype)percentStyle {
    return [self formatterWithStyle:NSNumberFormatterPercentStyle];
}

+ (instancetype)formatterWithStyle:(NSNumberFormatterStyle)style {
    return [[self alloc] initWithFormatterStyle:style];
}

- (instancetype)initWithFormatterStyle:(NSNumberFormatterStyle)style {
    if (self = [self init]) {
        self.numberStyle = style;
    }
    return self;
}

- (NSString *)stringFromNumber:(NSNumber *)number withPrecision:(NSUInteger)p {
    self.maximumFractionDigits = p;
    return [self stringFromNumber:number];
}


@end

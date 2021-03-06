//
//  NSNumberFormatter+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-27.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (AnobiKit)

+ (instancetype)currencyStyleWithCode:(NSString *)currencyCode;
+ (instancetype)formatterWithStyle:(NSNumberFormatterStyle)style;
+ (instancetype)percentStyle;

- (NSString *)stringFromNumber:(NSNumber *)number withPrecision:(NSUInteger)p;

@end

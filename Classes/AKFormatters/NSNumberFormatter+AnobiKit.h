//
//  NSNumberFormatter+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 27.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (AnobiKit)

+ (instancetype)defaultFormatter;
- (NSString *)stringFromNumber:(NSNumber *)num numberStyle:(NSNumberFormatterStyle)nstyle;
- (NSString *)stringFromNumber:(NSNumber *)num numberStyle:(NSNumberFormatterStyle)nstyle precision:(NSUInteger)p;
- (NSString *)currencyStyleStringFromNumber:(NSNumber *)num currencyCode:(NSString *)cc;


@end

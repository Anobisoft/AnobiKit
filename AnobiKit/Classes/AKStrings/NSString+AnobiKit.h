//
//  NSString+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 17.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AnobiKit)

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (BOOL)isValidEmail;
- (BOOL)isValidLinkWithScheme:(NSString *)scheme;
- (BOOL)isValidPhonenumber;
- (BOOL)isValidType:(NSTextCheckingType)type;
- (BOOL)isValidType:(NSTextCheckingType)type withTest:(BOOL (^)(NSTextCheckingResult *result, NSMatchingFlags flags))test;

@end

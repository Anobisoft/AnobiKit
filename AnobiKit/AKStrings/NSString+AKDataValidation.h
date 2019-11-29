//
//  NSString+AKDataValidation.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-08-13.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AKDataValidation)

- (BOOL)isValidEmail;
- (BOOL)isValidLinkWithScheme:(NSString *)scheme;
- (BOOL)isValidPhonenumber;
- (BOOL)isValidType:(NSTextCheckingType)type;
- (BOOL)isValidType:(NSTextCheckingType)type withTest:(BOOL (^)(NSTextCheckingResult *result, NSMatchingFlags flags))test;

@end

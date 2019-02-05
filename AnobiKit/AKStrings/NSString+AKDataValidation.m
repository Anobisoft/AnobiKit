//
//  NSString+AKDataValidation.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13/08/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSString+AKDataValidation.h"

@implementation NSString (AKDataValidation)

- (BOOL)isValidEmail {
    return [self isValidLinkWithScheme:@"mailto"];
}

- (BOOL)isValidLinkWithScheme:(NSString *)scheme {
    return [self isValidType:NSTextCheckingTypeLink
                    withTest:^BOOL(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags) {
                        return result.URL && [[result.URL scheme] isEqualToString:scheme];
                    }];
}

- (BOOL)isValidPhonenumber {
    return [self isValidType:NSTextCheckingTypePhoneNumber];
}

- (BOOL)isValidType:(NSTextCheckingType)type {
    return [self isValidType:type withTest:nil];
}

- (BOOL)isValidType:(NSTextCheckingType)type withTest:(BOOL (^)(NSTextCheckingResult *result,
                                                                NSMatchingFlags flags))test {
    NSError *error;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:type
                                                               error:&error];
    NSRange fullRange = NSMakeRange(0, self.length);
    __block BOOL valid = false;
    
    id testBlock = ^(NSTextCheckingResult * _Nullable result,
                     NSMatchingFlags flags,
                     BOOL * _Nonnull stop) {
        
        *stop = valid = (result.resultType & type) // isExpectedType
                        && NSEqualRanges(result.range, fullRange) // rangeOK
                        && (test ? test(result, flags) : true);
    };
    
    [detector enumerateMatchesInString:self
                               options:NSMatchingReportCompletion
                                 range:fullRange
                            usingBlock:testBlock];
    
    return valid;
}

@end

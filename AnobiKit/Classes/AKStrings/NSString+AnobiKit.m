//
//  NSString+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 17.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSString+AnobiKit.h"

@implementation NSString (AnobiKit)

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    
    for (; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer range:NSMakeRange(location, length)];
    
    for (; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

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
    
    void(^testBlock)(NSTextCheckingResult * _Nullable result,
                          NSMatchingFlags flags,
                          BOOL * _Nonnull stop) = ^(NSTextCheckingResult * _Nullable result,
                                                    NSMatchingFlags flags,
                                                    BOOL * _Nonnull stop) {
        BOOL isExpectedType = (result.resultType & type);
        BOOL rangeOK = isExpectedType && NSEqualRanges(result.range, fullRange);
        BOOL testOK = rangeOK && (test ? test(result, flags) : true);
        if (testOK) {
            *stop = valid = true;
        }
    };
    
    [detector enumerateMatchesInString:self
                               options:NSMatchingReportCompletion
                                 range:fullRange
                            usingBlock:testBlock];
    
    return valid;
}

@end

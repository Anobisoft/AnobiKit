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
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:&error];
    __block BOOL emailDetected = false;
    
    [detector enumerateMatchesInString:self
                               options:kNilOptions
                                 range:NSMakeRange(0, self.length)
                            usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                if (result.URL && [[result.URL scheme] isEqualToString:@"mailto"]) {
                                    NSString *abs = result.URL.absoluteString;
                                    if ([abs isEqualToString:self]) {
                                        emailDetected = true;
                                        *stop = true;
                                    } else {
                                        NSString *abs_scheme_cut;
                                        abs_scheme_cut = [abs stringByReplacingOccurrencesOfString:result.URL.scheme withString:@""];
                                        abs_scheme_cut = [abs_scheme_cut stringByTrimmingLeadingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
                                        if ([abs_scheme_cut isEqualToString:self]) {
                                            emailDetected = true;
                                            *stop = true;
                                        }
                                    }
                                }
                            }];
    
    return emailDetected;
}

@end

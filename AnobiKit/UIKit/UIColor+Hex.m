//
//  UIColor+Hex.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-06-16.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "UIColor+Hex.h"

UIColor * UIColorWithHexRGB(unsigned rgbColor, CGFloat alpha) {
    return [UIColor colorWithHexRGB:rgbColor alpha:alpha];
}

UIColor * UIColorWithHexString(NSString *string) {
    return [UIColor colorWithHexString:string];
}

@implementation UIColor (Hex)

+ (instancetype)colorWithHexString:(NSString *)string {
    return [self colorWithHexString:string alpha:1.0];
}

+ (instancetype)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
    NSString *trim = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *hex = [trim stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    unsigned rgbColor = 0;
    [scanner scanHexInt:&rgbColor];
    return [self colorWithHexRGB:rgbColor alpha:alpha];
}

+ (instancetype)colorWithHexRGB:(unsigned)rgb alpha:(CGFloat)alpha {
    return [self colorWithRed:(CGFloat)((rgb & 0xFF0000) >> 0x10) / 255.0
                        green:(CGFloat)((rgb & 0x00FF00) >> 0x08) / 255.0
                         blue:(CGFloat)((rgb & 0x0000FF) >> 0x00) / 255.0
                        alpha:alpha];
}

@end

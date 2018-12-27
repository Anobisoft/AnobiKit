//
//  UIColor+Hex.m
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 16.06.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "UIColor+Hex.h"

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

+ (instancetype)colorWithHexRGB:(unsigned)rgbColor alpha:(CGFloat)alpha {
    return [self colorWithRed:(CGFloat)((rgbColor & 0xFF0000) >> 0x10) / 255.0
                        green:(CGFloat)((rgbColor & 0x00FF00) >> 0x08) / 255.0
                         blue:(CGFloat)((rgbColor & 0x0000FF) >> 0x00) / 255.0
                        alpha:alpha];
}

@end

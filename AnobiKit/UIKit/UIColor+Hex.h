//
//  UIColor+Hex.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 16.06.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if !TARGET_OS_MAC

#import <UIKit/UIKit.h>

UIColor * UIColorWithHexRGB(unsigned rgbColor, CGFloat alpha);
UIColor * UIColorWithHexString(NSString *string);

@interface UIColor (Hex)

+ (instancetype)colorWithHexString:(NSString *)string;
+ (instancetype)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;
+ (instancetype)colorWithHexRGB:(unsigned)icolor alpha:(CGFloat)alpha;

@end

#endif

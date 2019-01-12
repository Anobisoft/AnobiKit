//
//  CALayer+XibConfiguration.m
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 24.10.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

#endif

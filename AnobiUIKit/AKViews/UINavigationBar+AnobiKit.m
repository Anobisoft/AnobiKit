//
//  UINavigationBar+AnobiKit.m
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 27.12.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

#import "UINavigationBar+AnobiKit.h"

@implementation UINavigationBar (AnobiKit)

- (UIColor *)titleTextColor {
    return self.titleTextAttributes[NSForegroundColorAttributeName];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    NSMutableDictionary *titleTextAttributes = self.titleTextAttributes.mutableCopy;
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary new];
    }
    titleTextAttributes[NSForegroundColorAttributeName] = titleTextColor;
    self.titleTextAttributes = titleTextAttributes;
}

@end

#endif

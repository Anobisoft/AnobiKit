//
//  UINavigationBar+AnobiKit.m
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 27.12.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

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

//
//  NSBundle+UIKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 09/04/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSBundle+UIKit.h"
#import <AnobiKit/NSBundle+AnobiKit.h>

NSString * UIKitLocalizedString(NSString *key) {
    return [[NSBundle UIKitBundle] localizedStringForKey:key];
}

@implementation NSBundle (UIKit)

+ (NSBundle *)UIKitBundle {
    return [self bundleForClass:UIColor.class];
}

@end

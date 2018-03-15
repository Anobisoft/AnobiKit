//
//  NSBundle+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSBundle+AnobiKit.h"

#define UIKitBundle [NSBundle bundleWithIdentifier:@"com.apple.UIKit"]

@implementation NSBundle (AnobiKit)

+ (NSString *)appVersion {
    return [NSString stringWithFormat:@"%@b%@", [self appShortVersion], [self appBuildVersion]];
}

+ (NSString *)appShortVersion {
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[[self mainBundle] infoDictionary] objectForKey:(id)kCFBundleVersionKey];
}

+ (NSString *)appName {
    return [NSBundle mainBundle].infoDictionary[(NSString*)kCFBundleNameKey];
}

+ (NSString *)appDisplayName {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"] ?: [self appName];
}

+ (instancetype)UIKit {
    return [self bundleWithIdentifier:@"com.apple.UIKit"];
}

- (NSArray<NSString *> *)UIKitLocalizationKeys {
    NSString *path = [UIKitBundle pathForResource:@"Localizable" ofType:@"strings"];
    return [NSDictionary dictionaryWithContentsOfFile:path].allKeys;
}

- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil table:nil];
}



@end

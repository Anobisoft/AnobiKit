//
//  AKBundle.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKBundle.h"

NSString * UIKitLocalizedString(NSString *key) {
    return [[NSBundle UIKitBundle] localizedStringForKey:key];
}

NSString * AKLocalizedString(NSString *key) {
    return [[NSBundle mainBundle] localizedStringForKey:key];
}

NSString * const CFBundleShortVersionKey = @"CFBundleShortVersionString";
NSString * const CFBundleDisplayNameKey = @"CFBundleDisplayName";

@implementation NSBundle (AnobiKit)

+ (instancetype)UIKitBundle {
    return [self bundleForClass:UIApplication.class];
}



+ (NSString *)appName {
    return self.mainBundle.infoDictionary[(id)kCFBundleNameKey];
}

+ (NSString *)appDisplayName {
    return self.mainBundle.infoDictionary[CFBundleDisplayNameKey] ?: [self appName];
}



+ (NSString *)appVersion {
    return [NSString stringWithFormat:@"v%@ build %@", [self appShortVersion], [self appBuildVersion]];
}

+ (NSString *)appShortVersion {
    return self.mainBundle.infoDictionary[CFBundleShortVersionKey];
}

+ (NSString *)appBuildVersion {
    return self.mainBundle.infoDictionary[(id)kCFBundleVersionKey];
}



- (NSDictionary<NSString *, NSString *> *)localizationTable {
    return [self localizationTableWithName:@"Localizable"];
}

- (NSDictionary<NSString *, NSString *> *)localizationTableWithName:(NSString *)name {
    NSString *path = [self pathForResource:name ofType:@"strings"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil table:nil];
}

@end

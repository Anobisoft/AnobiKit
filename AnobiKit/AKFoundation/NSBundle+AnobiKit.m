//
//  NSBundle+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSBundle+AnobiKit.h"
#import <UIKit/UIColor.h>


NSString * AKLocalizedString(NSString *key) {
    return [[NSBundle mainBundle] localizedStringForKey:key];
}

NSString * UIKitLocalizedString(NSString *key) {
    return [[NSBundle UIKitBundle] localizedStringForKey:key];
}

NSString * const CFBundleShortVersionKey = @"CFBundleShortVersionString";
NSString * const CFBundleDisplayNameKey = @"CFBundleDisplayName";

@implementation NSBundle (AnobiKit)

+ (NSBundle *)UIKitBundle {
    return [self bundleForClass:UIColor.class];
}

#pragma mark - Application name

- (NSString *)name {
    return self.infoDictionary[(id)kCFBundleNameKey];
}

- (NSString *)displayName {
    return self.infoDictionary[CFBundleDisplayNameKey] ?: self.name;
}

+ (NSString *)applicationName {
    return self.mainBundle.name;
}

+ (NSString *)applicationDisplayName {
    return self.mainBundle.displayName;
}


#pragma mark - Application version

- (NSString *)version {
    return [NSString stringWithFormat:@"v%@ build %@", [self shortVersion], [self buildVersion]];
}

- (NSString *)shortVersion {
    return self.infoDictionary[CFBundleShortVersionKey];
}

- (NSString *)buildVersion {
    return self.infoDictionary[(id)kCFBundleVersionKey];
}

+ (NSString *)applicationVersion {
    return self.mainBundle.version;
}

+ (NSString *)applicationShortVersion {
    return self.mainBundle.shortVersion;
}

+ (NSString *)applicationBuildVersion {
    return self.mainBundle.buildVersion;
}


#pragma mark - Localization

- (NSDictionary<NSString *, NSString *> *)localizationTable {
    return [self localizationTableWithName:@"Localizable"];
}

- (NSDictionary<NSString *, NSString *> *)localizationTableWithName:(NSString *)name {
    NSString *path = [self pathForResource:name ofType:@"strings"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    id obj = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (error && obj == nil) {
        @throw error;
        return nil;
    }
    if ([obj isKindOfClass:NSDictionary.class]) {
        return obj;
    }    
    @throw NSInternalInconsistencyException;
    return nil;
}

- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil table:nil];
}

@end

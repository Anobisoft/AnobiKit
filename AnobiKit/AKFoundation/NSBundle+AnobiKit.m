//
//  NSBundle+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSBundle+AnobiKit.h"
#import <WatchKit/WatchKit.h>
#import <WatchKit/WKDefines.h>
#import <WatchKit/WKInterfaceObject.h>
#import <WatchKit/WKInterfaceImage.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIAccessibilityConstants.h>

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

+ (NSString *)appName {
    return self.mainBundle.infoDictionary[(id)kCFBundleNameKey];
}

+ (NSString *)appDisplayName {
    return self.mainBundle.infoDictionary[CFBundleDisplayNameKey] ?: [self appName];
}



#pragma mark - Application version

+ (NSString *)appVersion {
    return [NSString stringWithFormat:@"v%@ build %@", [self appShortVersion], [self appBuildVersion]];
}

+ (NSString *)appShortVersion {
    return self.mainBundle.infoDictionary[CFBundleShortVersionKey];
}

+ (NSString *)appBuildVersion {
    return self.mainBundle.infoDictionary[(id)kCFBundleVersionKey];
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

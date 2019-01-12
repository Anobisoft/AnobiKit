//
//  NSBundle+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * AKLocalizedString(NSString *key);
NSString * UIKitLocalizedString(NSString *key);

extern NSString * const CFBundleShortVersionKey;
extern NSString * const CFBundleDisplayNameKey;

@interface NSBundle (AnobiKit)

+ (NSBundle *)UIKitBundle;

+ (NSString *)appName;
+ (NSString *)appDisplayName;

+ (NSString *)appVersion;
+ (NSString *)appShortVersion;
+ (NSString *)appBuildVersion;

- (NSString *)localizedStringForKey:(NSString *)key;
- (NSDictionary<NSString *, NSString *> *)localizationTable;

@end

//
//  NSBundle+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * AKLocalizedString(NSString *key);

extern NSString * const CFBundleShortVersionKey;
extern NSString * const CFBundleDisplayNameKey;

@interface NSBundle (AnobiKit)

- (NSString *)name;
- (NSString *)displayName;

- (NSString *)version;
- (NSString *)shortVersion;
- (NSString *)buildVersion;

- (NSString *)localizedStringForKey:(NSString *)key;
- (NSDictionary<NSString *, NSString *> *)localizationTable;


#pragma mark - Main bundle

+ (NSString *)applicationName;
+ (NSString *)applicationDisplayName;
+ (NSString *)applicationVersion;
+ (NSString *)applicationShortVersion;
+ (NSString *)applicationBuildVersion;

@end

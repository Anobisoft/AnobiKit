//
//  NSBundle+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (AnobiKit)

NSString * UIKitLocalizedString(NSString *key);
NSString * AKLocalizedString(NSString *key);

+ (NSString *)appVersion;
+ (NSString *)appShortVersion;
+ (NSString *)appBuildVersion;
+ (NSString *)appName;
+ (NSString *)appDisplayName;

+ (instancetype)UIKitBundle;
- (NSArray<NSString *> *)localizationKeys;
- (NSString *)localizedStringForKey:(NSString *)key;

@end

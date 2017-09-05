//
//  AKTheme.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKTypes.h"

#define AKThemeColorKey_mainBackground @"mainBackground"
#define AKThemeColorKey_mainTint @"mainTint"
#define AKThemeColorKey_mainText @"mainText"
#define AKThemeColorKey_mainTitle @"mainTitle"
#define AKThemeColorKey_mainSubtext @"mainSubtext"

#define AKThemeColorKey_tableBackground @"tableBackground"
#define AKThemeColorKey_tableTint @"tableTint"
#define AKThemeColorKey_tableSeparator @"tableSeparator"
#define AKThemeColorKey_tableCellBackground @"tableCellBackground"
#define AKThemeColorKey_tableSecondaryCellBackground @"tableSecondaryCellBackground"
#define AKThemeColorKey_tableInactiveCellTint @"tableInactiveCellTint"
#define AKThemeColorKey_tableText @"tableText"

//#define AKThemeColorKey_ @""

#define AKThemeColorKey_navibar @"navibar"
#define AKThemeColorKey_navibarTint @"navibarTint"
#define AKThemeColorKey_navibarTitle @"navibarTitle"
#define AKThemeColorKey_navibarBackground @"navibarBackground"


#define AKThemeColorKey_toolbar @"toolbar"
#define AKThemeColorKey_toolbarTint @"toolbarTint"
#define AKThemeColorKey_toolbarBackground @"toolbarBackground"
#define AKThemeColorKey_toolbarPositive @"toolbarPositive"
#define AKThemeColorKey_toolbarNegative @"toolbarNegative"
#define AKThemeColorKey_toolbarPositiveTint @"toolbarPositiveTint"
#define AKThemeColorKey_toolbarNegativeTint @"toolbarNegativeTint"


#define AKThemeColorKey_searchbar @"searchbar"
#define AKThemeColorKey_searchbarTint @"searchbarTint"



@interface AKTheme : NSObject <DisableStdInstantiating, KeyedSubscript, IndexedSubscript>

@property (readonly) NSString *name;
@property (readonly) NSDictionary *keyedColors;
@property (readonly) NSArray *indexedColors;
@property (readonly) UIBarStyle barStyle;
- (UIColor *)objectForKeyedSubscript:(NSString *)key;
- (UIColor *)objectAtIndexedSubscript:(NSUInteger)idx;

+ (instancetype)currentTheme;
+ (void)setCurrentThemeNamed:(NSString *)name;
+ (instancetype)themeNamed:(NSString *)name;
+ (NSArray<NSString *> *)allNames;

@end

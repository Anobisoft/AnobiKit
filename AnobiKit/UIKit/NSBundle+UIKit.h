//
//  NSBundle+UIKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-04-09.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NSString * _Nullable UIKitLocalizedString(NSString *key);

@interface NSBundle (UIKit)

+ (NSBundle *)UIKitBundle;

@end

NS_ASSUME_NONNULL_END

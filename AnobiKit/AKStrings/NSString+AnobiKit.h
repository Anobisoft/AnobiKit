//
//  NSString+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 17.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AnobiKit)

- (NSString *)stringByTrimmingSuffix:(NSString *)suffix;
- (NSString *)stringByTrimmingPrefix:(NSString *)prefix;
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

@end

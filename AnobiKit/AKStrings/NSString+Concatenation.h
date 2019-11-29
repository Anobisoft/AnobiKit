//
//  NSString+Concatenation.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-12-27.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Concatenation)

- (NSString *) :(NSString *)append;
- (NSString *) :(NSString *)append :(NSString *)second;
- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third;
- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third :(NSString *)forth;
- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third :(NSString *)forth :(NSString *)fifth;

- (NSString *)concat:(NSString *)strings, ...;

@end

NS_ASSUME_NONNULL_END

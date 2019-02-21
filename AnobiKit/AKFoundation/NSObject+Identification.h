//
//  NSObject+Identification.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 21/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Identification)

+ (NSString *)classIdentifier;
- (NSString *)classIdentifier;

@end

NS_ASSUME_NONNULL_END

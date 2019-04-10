//
//  AKExample.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 10/04/2019.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKExample : NSObject

+ (instancetype)shared;

- (void)configManagerExample;
- (void)locationManagerExample;
- (void)dataValidationExample;
- (void)versionExample;
- (void)listExample;
- (void)subscriptExample;

- (void)bundleExample;

@end

NS_ASSUME_NONNULL_END

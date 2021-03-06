//
//  AKExample.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-04-10.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKExample : NSObject

+ (instancetype)shared;

- (void)configManagerExample;
- (void)dataValidationExample;
- (void)versionExample;
- (void)listExample;
- (void)subscriptExample;

- (void)bundleExample;
#if !TARGET_OS_TV
- (void)locationManagerExample;
#endif

@end

NS_ASSUME_NONNULL_END

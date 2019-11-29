//
//  AKSingleton.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-09-05.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKSingleton : NSObject

+ (instancetype)shared;
+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
+ (void)releaseInstance;
- (void)releaseInstance;

@end

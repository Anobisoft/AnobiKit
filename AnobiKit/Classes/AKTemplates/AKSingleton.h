//
//  AKSingleton.h
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//
//

#import <Foundation/Foundation.h>

@interface AKSingleton : NSObject

+ (instancetype)shared;

+ (instancetype)allocWithZone:(struct _NSZone *)zone NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;


@end

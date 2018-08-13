//
//  AKPropertyMapException.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSExceptionName const AKPropertyMapExceptionName;

NS_ASSUME_NONNULL_BEGIN

@interface AKPropertyMapException : NSException

+ (instancetype)exception;
+ (instancetype)exceptionReason:(nullable NSString *)reason;
+ (instancetype)exceptionReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)info;
+ (instancetype)exceptionUserInfo:(nullable NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END

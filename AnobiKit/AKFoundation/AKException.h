//
//  AKException.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 02/10/2018.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKInstantiationException;

NS_ASSUME_NONNULL_BEGIN

@interface AKException : NSException

+ (instancetype)exception;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo;
+ (instancetype)exception:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo;


@end

@interface NSObject (AKException)

- (AKException *)exceptionWithReason:(nullable NSString *)reason;
- (AKException *)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo;

+ (AKInstantiationException *)abstractClassInstantiationException;

@end

NS_ASSUME_NONNULL_END

#pragma mark - concrete exceptions

@interface AKFileNotFoundException : AKException

+ (instancetype)exceptionWithPath:(NSString *)path;

@end

@interface AKInstantiationException : AKException

+ (instancetype)abstractClassInstantiationException;

@end

@interface AbstractMethodException : AKException

@end

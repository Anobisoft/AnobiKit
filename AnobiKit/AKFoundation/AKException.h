//
//  AKException.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 02/10/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKInstantiationException;

NS_ASSUME_NONNULL_BEGIN

@interface AKException : NSException

+ (instancetype)exception;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo;

@end

@interface NSObject (AKException)

- (AKException *)exceptionWithReason:(nullable NSString *)reason;
- (AKException *)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo;

+ (AKInstantiationException *)abstractClassInstantiationException;

+ (BOOL)conformsToProtocolThrows:(Protocol *)protocol;
- (BOOL)conformsToProtocolThrows:(Protocol *)protocol;

@end


#pragma mark - concrete exceptions

@interface AKFileNotFoundException : AKException

+ (instancetype)exceptionWithPath:(nullable NSString *)path;

@end

@interface AKInstantiationException : AKException

+ (instancetype)abstractClassInstantiationException;

@end

@interface AKAbstractMethodException : AKException

@end

@interface AKProtocolException : AKException

+ (instancetype)class:(Class)class notConformsProtocol:(Protocol *)protocol;

@end

@interface AKIllegalArgumentException : AKException

@end

NS_ASSUME_NONNULL_END

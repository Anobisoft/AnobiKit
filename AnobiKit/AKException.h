//
//  AKException.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 02/10/2018.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKException : NSException

+ (instancetype)exception;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason;
+ (instancetype)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo;


@end

NS_ASSUME_NONNULL_END

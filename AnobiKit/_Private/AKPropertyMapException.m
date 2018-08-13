//
//  AKPropertyMapException.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKPropertyMapException.h"

NSExceptionName const AKPropertyMapExceptionName = @"AKPropertyMapException";

@implementation AKPropertyMapException

+ (instancetype)exception {
    return [self exceptionReason:nil userInfo:nil];
}

+ (instancetype)exceptionReason:(nullable NSString *)reason {
    return [self exceptionReason:reason userInfo:nil];
}

+ (instancetype)exceptionReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)info {
    return [[self alloc] initWithName:AKPropertyMapExceptionName reason:reason userInfo:info];
}

+ (instancetype)exceptionUserInfo:(nullable NSDictionary *)info {
    return [self exceptionReason:nil userInfo:info];
}

@end

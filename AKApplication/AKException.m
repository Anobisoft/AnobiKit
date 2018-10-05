//
//  AKException.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 02/10/2018.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKException.h"

@implementation AKException

+ (instancetype)exception {
    return [self exceptionWithReason:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    return [[self alloc] initWithName:NSStringFromClass(self) reason:reason userInfo:userInfo];
}

@end

@implementation NSObject (AKException)

- (void)throwExceptionWithReason:(nullable NSString *)reason {
    [self throwExceptionWithReason:reason userInfo:nil];
}

- (void)throwExceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo {
    NSString *exceptionName = [NSString stringWithFormat:@"%@Exception", NSStringFromClass(self.class)];
    @throw [NSException exceptionWithName:exceptionName reason:reason userInfo:userInfo];
}

@end

#pragma mark - concrete exceptions

@implementation AKFileNotFoundException

+ (instancetype)exceptionWithPath:(NSString *)path {
    return [self exceptionWithReason:nil userInfo:@{ @"path" : path }];
}

@end

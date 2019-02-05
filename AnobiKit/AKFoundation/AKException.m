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
    return [self exception:NSStringFromClass(self) reason:reason userInfo:userInfo];
}

+ (instancetype)exception:(NSString *)exception reason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    return [[self alloc] initWithName:exception reason:reason userInfo:userInfo];
}

@end

@implementation NSObject (AKException)

- (AKException *)exceptionWithReason:(nullable NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

- (AKException *)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo {
    NSString *exception = [NSStringFromClass(self.class) stringByAppendingString:@"Exception"];
    return [AKException exception:exception reason:reason userInfo:userInfo];
}

@end

#pragma mark - concrete exceptions

@implementation AKFileNotFoundException

+ (instancetype)exceptionWithPath:(NSString *)path {
    return [self exceptionWithReason:path userInfo:@{ @"path" : path }];
}

@end

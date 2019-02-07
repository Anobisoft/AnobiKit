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

+ (instancetype)exception:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    return [[self alloc] initWithName:name reason:reason userInfo:userInfo];
}

@end

@implementation NSObject (AKException)

- (AKException *)exceptionWithReason:(nullable NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

- (AKException *)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo {
    NSString *name = [NSStringFromClass(self.class) stringByAppendingString:@"Exception"];
    return [AKException exception:name reason:reason userInfo:userInfo];
}

+ (AKInstantiationException *)abstractClassInstantiationException {
    NSString *classBundleIdentifier = [NSBundle bundleForClass:self].bundleIdentifier;
    NSString *classIdentifier = [classBundleIdentifier stringByAppendingFormat:@".%@", NSStringFromClass(self)];
    NSString *reason = [NSString stringWithFormat:@"Could not instantiate class [%@]: Is it an abstract class?", classIdentifier];
    return [AKInstantiationException exceptionWithReason:reason];
}

@end

#pragma mark - concrete exceptions

@implementation AbstractMethodException

+ (instancetype)exception {
    NSArray *callStack = [NSThread callStackSymbols];
    NSString *abstractMethod = callStack[callStack.count - 2];
    NSString *reason = [NSString stringWithFormat:@"Could not call abstract method [%@]: it must be overridden", abstractMethod];
    return [self exceptionWithReason:reason];
}

@end

@implementation AKFileNotFoundException

+ (instancetype)exceptionWithPath:(NSString *)path {
    return [self exceptionWithReason:path userInfo:@{ @"path" : path }];
}

@end

@implementation AKInstantiationException

+ (instancetype)abstractClassInstantiationException {
    return [self exceptionWithReason:@"could not instantiate abstract class"];
}

@end


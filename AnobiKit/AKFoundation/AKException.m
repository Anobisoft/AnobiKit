//
//  AKException.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-02.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKException.h"
#import "NSObject+Identification.h"

static NSString * const AKExceptionNameSuffix = @"Exception";

@implementation AKException

+ (instancetype)exception {
    return [self exceptionWithReason:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    return [[self alloc] initWithName:self.classIdentifier reason:reason userInfo:userInfo];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@", self.class, self.reason];
}

@end

@implementation NSObject (AKException)

- (AKException *)exceptionWithReason:(nullable NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

- (AKException *)exceptionWithReason:(nullable NSString *)reason userInfo:(nullable NSDictionary *)userInfo {
    NSString *name = self.classIdentifier;
    if (![name hasSuffix:AKExceptionNameSuffix]) {
        name = [name stringByAppendingString:AKExceptionNameSuffix];
    }
    return [[AKException alloc] initWithName:name reason:reason userInfo:userInfo];
}

+ (AKInstantiationException *)abstractClassInstantiationException {
    NSString *reason = [NSString stringWithFormat:@"Could not instantiate class [%@]: Is it an abstract class?", self.classIdentifier];
    return [AKInstantiationException exceptionWithReason:reason];
}

+ (BOOL)conformsToProtocolThrows:(Protocol *)protocol {
    BOOL result = [self conformsToProtocol:protocol];
    if (!result) {
        @throw [AKProtocolException class:self notConformsProtocol:protocol];
    }
    return result;
}

- (BOOL)conformsToProtocolThrows:(Protocol *)protocol {
    return [self.class conformsToProtocolThrows:protocol];
}

@end

#pragma mark - concrete exceptions

@implementation AKAbstractMethodException

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

@implementation AKProtocolException

+ (instancetype)class:(Class)class notConformsProtocol:(Protocol *)protocol {
    NSString *protocolIdentifier = NSStringFromProtocol(protocol);
    NSString *reason = [NSString stringWithFormat:@"class [%@] must conforms to protocol [%@]", class.classIdentifier, protocolIdentifier];
    return [self exceptionWithReason:reason];
}

@end

@implementation AKIllegalArgumentException

@end

//
//  AKSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSingleton.h"
#import "NSThread+AnobiKit.h"

@implementation AKSingleton

static NSMutableDictionary<Class, __kindof AKSingleton *> *uniqueInstances;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstances = [NSMutableDictionary new];
    });
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = uniqueInstances[self];
        if (!instance) {
            instance = [[self alloc] init];
            uniqueInstances[(id<NSCopying>)self] = instance;
        }
    });
	return instance;
}

+ (instancetype)new {
    return [self shared];
}

- (id)copy {
	return self;
}

- (id)mutableCopy {
	return self;
}

+ (void)free {
    [uniqueInstances removeObjectForKey:self];
}

- (void)free {
    [self.class free];
}

@end

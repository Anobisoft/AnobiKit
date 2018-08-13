//
//  AKSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSingleton.h"
#import "AKThread.h"

@implementation AKSingleton

static NSMutableDictionary<NSString *, __kindof AKSingleton *> *uniqueInstances;

+ (void)load {
    uniqueInstances = [NSMutableDictionary new];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = uniqueInstances[NSStringFromClass(self)];
        if (!instance) {
            instance = [[self alloc] init];
            uniqueInstances[NSStringFromClass(self)] = instance;
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
    [uniqueInstances removeObjectForKey:NSStringFromClass(self)];
}

- (void)free {
    [self.class free];
}

@end

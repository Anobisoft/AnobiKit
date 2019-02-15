//
//  AKSingleton.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSingleton.h"
#import <AnobiKit/AKThread.h>

@implementation AKSingleton

static NSMutableDictionary<NSString *, __kindof AKSingleton *> *AKSingletonUniqueInstances;

+ (void)load {
    AKSingletonUniqueInstances = [NSMutableDictionary new];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = AKSingletonUniqueInstances[NSStringFromClass(self)];
        if (!instance) {
            instance = [[self alloc] init];
            AKSingletonUniqueInstances[NSStringFromClass(self)] = instance;
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

+ (void)releaseInstance {
    [AKSingletonUniqueInstances removeObjectForKey:NSStringFromClass(self)];
}

- (void)releaseInstance {
    [self.class releaseInstance];
}

@end

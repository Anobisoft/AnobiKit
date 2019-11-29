//
//  AKSingleton.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-09-05.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSingleton.h"
#import <AnobiKit/AKThread.h>
#import <AnobiKit/NSObject+Identification.h>

@implementation AKSingleton

static NSMutableDictionary<NSString *, __kindof AKSingleton *> *AKSingletonUniqueInstances;

+ (void)load {
    AKSingletonUniqueInstances = [NSMutableDictionary new];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = AKSingletonUniqueInstances[self.classIdentifier];
        if (!instance) {
            instance = [[self alloc] init];
            AKSingletonUniqueInstances[self.classIdentifier] = instance;
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
    [AKSingletonUniqueInstances removeObjectForKey:self.classIdentifier];
}

- (void)releaseInstance {
    [self.class releaseInstance];
}

@end

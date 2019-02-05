//
//  AKWeakSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKWeakSingleton.h"
#import <AnobiKit/AKThread.h>

@implementation AKWeakSingleton

static NSMapTable<NSString *, __kindof AKWeakSingleton *> *uniqueInstances;

+ (void)load {
    uniqueInstances = [NSMapTable strongToWeakObjectsMapTable];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = [uniqueInstances objectForKey:NSStringFromClass(self)];
        if (!instance) {
            instance = [[self alloc] init];
            [uniqueInstances setObject:instance forKey:NSStringFromClass(self)];
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

@end

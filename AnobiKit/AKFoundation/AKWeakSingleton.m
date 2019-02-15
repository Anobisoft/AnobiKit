//
//  AKWeakSingleton.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKWeakSingleton.h"
#import <AnobiKit/AKThread.h>

@implementation AKWeakSingleton

static NSMapTable<NSString *, __kindof AKWeakSingleton *> *AKWeakSingletonUniqueInstances;

+ (void)load {
    AKWeakSingletonUniqueInstances = [NSMapTable strongToWeakObjectsMapTable];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = [AKWeakSingletonUniqueInstances objectForKey:NSStringFromClass(self)];
        if (!instance) {
            instance = [[self alloc] init];
            [AKWeakSingletonUniqueInstances setObject:instance forKey:NSStringFromClass(self)];
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

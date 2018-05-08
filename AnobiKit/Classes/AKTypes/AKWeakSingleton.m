//
//  AKWeakSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKWeakSingleton.h"
#import "NSThread+AnobiKit.h"

@implementation AKWeakSingleton

static NSMapTable<Class, __kindof AKWeakSingleton *> *uniqueInstances;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstances = [NSMapTable weakToWeakObjectsMapTable];
    });
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = [uniqueInstances objectForKey:self];
        if (!instance) {
            instance = [[self alloc] init];
            [uniqueInstances setObject:instance forKey:self];
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

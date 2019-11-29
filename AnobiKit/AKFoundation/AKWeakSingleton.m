//
//  AKWeakSingleton.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-09-05.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKWeakSingleton.h"
#import <AnobiKit/AKThread.h>
#import <AnobiKit/NSObject+Identification.h>

@implementation AKWeakSingleton

static NSMapTable<NSString *, __kindof AKWeakSingleton *> *AKWeakSingletonUniqueInstances;

+ (void)load {
    AKWeakSingletonUniqueInstances = [NSMapTable strongToWeakObjectsMapTable];
}

+ (instancetype)shared {
    __block id instance;
    dispatch_syncmain(^{
        instance = [AKWeakSingletonUniqueInstances objectForKey:self.classIdentifier];
        if (!instance) {
            instance = [[self alloc] init];
            [AKWeakSingletonUniqueInstances setObject:instance forKey:self.classIdentifier];
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

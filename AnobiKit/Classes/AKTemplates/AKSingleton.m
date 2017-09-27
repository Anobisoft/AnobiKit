//
//  AKSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//
//

#import "AKSingleton.h"

@implementation AKSingleton

static NSMutableDictionary <Class, __kindof AKSingleton *> *uniqueInstances;
static dispatch_group_t creationGroup;

+ (void)initialize {
	[super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstances = [NSMutableDictionary new];
        creationGroup = dispatch_group_create();
    });
}

+ (instancetype)shared {
    if (![NSThread isMainThread]) {
        dispatch_group_wait(creationGroup, DISPATCH_TIME_FOREVER);
    }
    dispatch_group_enter(creationGroup);
	id instance = uniqueInstances[self];
	if (!instance) {
		instance = [[self alloc] init];
		uniqueInstances[(id <NSCopying>)self] = instance;
	}
    dispatch_group_leave(creationGroup);
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

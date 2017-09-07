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

+ (void)initialize {
	[super initialize];
	uniqueInstances = [NSMutableDictionary new];
}

+ (instancetype)shared {
	id instance = uniqueInstances[self];
	if (!instance) {
		instance = [[self alloc] init];
		uniqueInstances[(id <NSCopying>)self] = instance;
	}
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

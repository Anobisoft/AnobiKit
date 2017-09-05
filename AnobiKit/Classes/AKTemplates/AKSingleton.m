//
//  AKSingleton.m
//  Pods
//
//  Created by Stanislav Pletnev on 05.09.17.
//
//

#import "AKSingleton.h"

@implementation AKSingleton

+ (instancetype)new {
	return [self shared];
}

+ (instancetype)shared {
	static id instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	return instance;
}

- (id)copy {
	return self;
}

- (id)mutableCopy {
	return self;
}

@end

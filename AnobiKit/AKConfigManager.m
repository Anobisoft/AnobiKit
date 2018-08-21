//
//  AKConfig.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigManager.h"
#import "AKBundle.h"

@implementation AKConfigManager {
    NSCache<NSString *, id> *configsCache;
}

+ (instancetype)manager {
	return [self shared];
}

- (instancetype)init {
    if (self = [super init]) {
        configsCache = [NSCache new];
        configsCache.totalCostLimit = 0x4000; // 16KB
    }
    return self;
}

- (id)configWithName:(NSString *)name {
    id config = [configsCache objectForKey:name];
    if  (config) {
        return config;
    }
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        @throw [NSException exceptionWithName:NSObjectNotAvailableException reason:@"File not found." userInfo:@{ @"path" : path }];
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    config = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (error) {
        @throw error;
    }
    if ([config isKindOfClass:NSDictionary.class] || [config isKindOfClass:NSArray.class]) {
        [configsCache setObject:config forKey:name];
    }
    return config;
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [self configWithName:key];
}

@end

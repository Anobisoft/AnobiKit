//
//  AKConfigManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigManager.h"
#import "NSBundle+AnobiKit.h"
#import "AKFileManager.h"
#import <AnobiKit/AKException.h>

@implementation AKConfigManager {
    NSCache<NSString *, id> *configsCache;
}

+ (instancetype)manager {
	return [self shared];
}

- (void)setCachesize:(NSUInteger)cachesize {
    if (cachesize) {
        if (!configsCache) {
            configsCache = [NSCache new];
        }
        configsCache.totalCostLimit = cachesize;
    } else {
        configsCache = nil;
    }
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
    
    AKFileManager *fileManager = [AKFileManager resourcesManager];
    NSString *path = [fileManager URLWithFilename:name extension:@"plist"].path;
    if (![fileManager fileExistsAtPath:path]) {
        @throw [AKFileNotFoundException exceptionWithPath:path];
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

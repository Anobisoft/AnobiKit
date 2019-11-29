//
//  AKConfigManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-14.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigManager.h"
#import <AnobiKit/NSBundle+AnobiKit.h>
#import <AnobiKit/AKFileManager.h>
#import <AnobiKit/AKException.h>

@interface AKConfigManager ()

@property (nonatomic) NSCache<NSString *, id> *configsCache;

@end

@implementation AKConfigManager

+ (instancetype)manager {
    return [self shared];
}

+ (NSUInteger)cachesize {
    return self.manager.cachesize;
}

+ (void)setCachesize:(NSUInteger)cachesize {
    self.manager.cachesize = cachesize;
}

+ (id)configWithName:(NSString *)name {
    return [self.manager configWithName:name];
}


- (NSUInteger)cachesize {
    return self.configsCache.totalCostLimit;
}

- (void)setCachesize:(NSUInteger)cachesize {
    if (cachesize) {
        if (!self.configsCache) {
            self.configsCache = [NSCache new];
        }
        self.configsCache.totalCostLimit = cachesize;
    } else {
        self.configsCache = nil;
    }
}

- (instancetype)init {
    if (self = [super init]) {
        _configsCache = [NSCache new];
        _configsCache.totalCostLimit = 0x4000; // 16KB
    }
    return self;
}

- (id)configWithName:(NSString *)name {
    id config = [self.configsCache objectForKey:name];
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
    if (config) {
        [self.configsCache setObject:config forKey:name];
    }
    return config;
}

#pragma mark - KeyedSubscript

- (id)objectForKeyedSubscript:(NSString *)key {
    return [self configWithName:key];
}

@end

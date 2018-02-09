//
//  AKConfig.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigManager.h"
#import "NSBundle+AnobiKit.h"

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
    if (!config) {
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            config = [NSDictionary dictionaryWithContentsOfFile:path];
            if (!config) {
                config = [NSArray arrayWithContentsOfFile:path];
            }
            [configsCache setObject:config forKey:name];
        } else {
            NSString *reason = [NSString stringWithFormat:@"File '%@' not found.", path];
            @throw [NSException exceptionWithName:NSObjectNotAvailableException reason:reason userInfo:nil];
        }
    }
    return config;
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [self configWithName:key];
}

+ (NSDictionary *)defaultConfig {
    return [self configWithName:AKDefaultConfigName];
}





@end

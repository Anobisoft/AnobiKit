//
//  AKConfigs.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigs.h"
#import "NSBundle+AnobiKit.h"

@implementation AKConfigs

#define AKConfigsDefaultName @"AKMainConfig"

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initInstance];
    });
    return instance;
}

- (instancetype)initInstance {
    if (self = [super init]) {
        
    }
    return self;
}

+ (NSDictionary *)mainConfig {
    return [self shared][AKConfigsDefaultName];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    static NSMutableDictionary *configs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configs = [NSMutableDictionary new];
    });
    
    id config = configs[key];
    
    if (!config) {
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:key] stringByAppendingPathExtension:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            config = [NSDictionary dictionaryWithContentsOfFile:path];
            if (!config) {
                config = [NSArray arrayWithContentsOfFile:path];
            }
            configs[key] = config;
        } else {
            @throw [NSException exceptionWithName:[NSString stringWithFormat:@"File '%@' not found.", path] reason:nil userInfo:nil];
        }
    }
    return config;
}

+ (NSDictionary *)entitlements {
    static NSDictionary *entitlements = nil;
    if (!entitlements) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSBundle appName] ofType:@"entitlements"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            entitlements = [NSDictionary dictionaryWithContentsOfFile:path];
        } else {
            entitlements = @{};
        }
    }
    return entitlements;
}

+ (NSString *)appGroupIdentifier {
    NSArray<NSString *> *array = [self entitlements][@"com.apple.security.application-groups"];
    if (array.count) {
        return array.firstObject;
    } else {
        return nil;
    }
}

+ (NSURL *)dataContainerURL {
    static dispatch_once_t onceToken;
    static NSURL *containerURL = nil;
    dispatch_once(&onceToken, ^{
        NSString *appGroupIdentifier = [self appGroupIdentifier];        
        if (appGroupIdentifier) {
            containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroupIdentifier];
        } else {
            containerURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        }
    });

    return containerURL;
}

+ (NSURL *)dataFileURLWithName:(NSString *)fn {
    return [[[self dataContainerURL] URLByAppendingPathComponent:fn] URLByAppendingPathExtension:@"dat"];
}

+ (NSURL *)dataFileURLWithName:(NSString *)fn version:(NSUInteger)version {
    return [self dataFileURLWithName:[NSString stringWithFormat:@"%@_v%ld", fn, (unsigned long)version]];
}

@end
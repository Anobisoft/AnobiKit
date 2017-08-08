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

static NSMutableDictionary<NSString *, NSURL *> *URLByAppGroupIdentifiers;
- (instancetype)initInstance {
    if (self = [super init]) {
        URLByAppGroupIdentifiers = [NSMutableDictionary new];
    }
    return self;
}

+ (NSDictionary *)defaultConfig {
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

+ (NSURL *)documentsURL {
    static dispatch_once_t onceToken;
    static NSURL *containerURL = nil;
    dispatch_once(&onceToken, ^{
        containerURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    });
    return containerURL;
}


+ (NSURL *)initDataFileContainerWithAppGroupIdentifier:appGroupIdentifier {
    NSURL *tryURL = URLByAppGroupIdentifiers[appGroupIdentifier];
    if (!tryURL) {
        tryURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroupIdentifier];
    }
    BOOL isDirectory = NO;
    if (tryURL && [[NSFileManager defaultManager] fileExistsAtPath:tryURL.path isDirectory:&isDirectory] && isDirectory) {
        URLByAppGroupIdentifiers[appGroupIdentifier] = tryURL;
        return tryURL;
    } else {
        return [self documentsURL];
    }
}

+ (NSURL *)dataFileContainer {
    if (URLByAppGroupIdentifiers.count) {
        return URLByAppGroupIdentifiers.allValues.firstObject;
    } else {
        return [self documentsURL];
    }
}

+ (NSURL *)dataFileURLWithName:(NSString *)fn {
    return [[[self dataFileContainer] URLByAppendingPathComponent:fn] URLByAppendingPathExtension:@"dat"];
}

+ (NSURL *)dataFileURLWithName:(NSString *)fn version:(NSUInteger)version {
    return [self dataFileURLWithName:[NSString stringWithFormat:@"%@_v%lu", fn, (unsigned long)version]];
}



@end

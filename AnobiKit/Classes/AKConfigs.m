//
//  AKConfigs.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKConfigs.h"
#import "NSBundle+AnobiKit.h"

@implementation NSURL (AnobiKit)

- (NSURL *)fileURLWithName:(NSString *)fn {
    return [[self URLByAppendingPathComponent:fn] URLByAppendingPathExtension:@"dat"];
}
- (NSURL *)fileURLWithName:(NSString *)fn version:(NSUInteger)ver {
    return [self fileURLWithName:[NSString stringWithFormat:@"%@_v%lu", fn, (unsigned long)ver]];
}

@end

@implementation AKConfigs

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (id)configWithName:(NSString *)name {
    static NSMutableDictionary *configs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configs = [NSMutableDictionary new];
    });
    
    id config = configs[name];
    
    if (!config) {
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            config = [NSDictionary dictionaryWithContentsOfFile:path];
            if (!config) {
                config = [NSArray arrayWithContentsOfFile:path];
            }
            configs[name] = config;
        } else {
            @throw [NSException exceptionWithName:[NSString stringWithFormat:@"File '%@' not found.", path] reason:nil userInfo:nil];
        }
    }
    return config;
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [[self class] configWithName:key];
}

+ (NSDictionary *)defaultConfig {
    return [self configWithName:AKConfigsDefaultName];
}

#pragma mark -

+ (NSURL *)documentsURL {
    static NSURL *containerURL = nil;
    static dispatch_once_t onceToken;    
    dispatch_once(&onceToken, ^{
        containerURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    });
    return containerURL;
}

+ (NSURL *)documentsFileURLWithName:(NSString *)fn {
    return [[self documentsURL] fileURLWithName:fn];
}

+ (NSURL *)documentsFileURLWithName:(NSString *)fn version:(NSUInteger)ver {
    return [[self documentsURL] fileURLWithName:fn version:ver];
}

#pragma mark -

static NSMutableDictionary<NSString *, NSURL *> *URLByAppGroupIdentifiers = nil;
+ (NSURL *)containerWithAppGroupIdentifier:(NSString *)appGrId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        URLByAppGroupIdentifiers = [NSMutableDictionary new];
    });
    NSURL *tryURL = URLByAppGroupIdentifiers[appGrId];
    if (!tryURL) {
        tryURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGrId];
    }
    BOOL isDirectory = NO;
    if (tryURL && [[NSFileManager defaultManager] fileExistsAtPath:tryURL.path isDirectory:&isDirectory] && isDirectory) {
        URLByAppGroupIdentifiers[appGrId] = tryURL;
        
    }
    return tryURL ?: [self documentsURL];
}

+ (NSURL *)sharedAppGroupIdentifier:(NSString *)appGrId fileURLWithName:(NSString *)fn {
    return [[self containerWithAppGroupIdentifier:appGrId] fileURLWithName:fn];
}

+ (NSURL *)sharedAppGroupIdentifier:(NSString *)appGrId fileURLWithName:(NSString *)fn version:(NSUInteger)ver {
    return [[self containerWithAppGroupIdentifier:appGrId] fileURLWithName:fn version:ver];
}

#pragma mark -

+ (NSURL *)defaultContainer {
    if (URLByAppGroupIdentifiers.count) {
        return URLByAppGroupIdentifiers.allValues.firstObject;
    } else {
        return [self documentsURL];
    }
}

+ (NSURL *)defaultDataFileURLWithName:(NSString *)fn {
    return [[self defaultContainer] fileURLWithName:fn];
}

+ (NSURL *)defaultDataFileURLWithName:(NSString *)fn version:(NSUInteger)ver {
    return [[self defaultContainer] fileURLWithName:fn version:ver];
}



@end

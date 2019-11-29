//
//  AKFileManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-02-09.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKFileManager.h"
#import <AnobiKit/AKException.h>

@implementation NSURL (AnobiKit)

- (NSURL *)URLByAppendingFilename:(NSString *)fn extension:(NSString *)ext {
    return [[self URLByAppendingPathComponent:fn] URLByAppendingPathExtension:ext];
}

- (NSURL *)URLByAppendingFilename:(NSString *)fn version:(NSString *)ver extension:(NSString *)ext {
    NSString *filename = [NSString stringWithFormat:@"%@_%@", fn, ver];
    return [self URLByAppendingFilename:filename extension:ext];
}

@end

@implementation AKFileManager

#pragma mark -

+ (instancetype)manager {
    static id _singleInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [[self alloc] initWithDirectoryURL:self.documentsDirectoryURL];
    });
    return _singleInstance;
}

+ (instancetype)resourcesManager {
    static id _resourcesManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _resourcesManager = [[self alloc] initWithDirectoryURL:self.mainBundleResourceURL];
    });
    return _resourcesManager;
}

+ (instancetype)managerWithDirectoryURL:(NSURL *)directory {
    return [[self alloc] initWithDirectoryURL:directory];
}

- (instancetype)initWithDirectoryURL:(NSURL *)directory {
    if (self = [self init]) {
        _defaultDirectory = directory;
    }
    return self;
}

#pragma mark -

+ (NSURL *)documentsDirectoryURL {
    static NSURL *_cachedDocumentsDirectoryURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cachedDocumentsDirectoryURL = [self.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    });
    return _cachedDocumentsDirectoryURL;
}

+ (NSURL *)mainBundleResourceURL {
    return NSBundle.mainBundle.resourceURL;
}

+ (NSURL *)defaultAppGroupDirectoryURL {
    return [self directoryURLWithAppGroup:nil];
}

+ (NSURL *)directoryURLWithAppGroup:(NSString *)appGroupIdentifier {
    static NSMutableDictionary<NSString *, NSURL *> *URLByAppGroupIdentifiers = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        URLByAppGroupIdentifiers = [NSMutableDictionary new];
    });
    
    if (!appGroupIdentifier) appGroupIdentifier = [@"appgroup." stringByAppendingString:[NSBundle mainBundle].bundleIdentifier];
    
    NSURL *result = URLByAppGroupIdentifiers[appGroupIdentifier];
    if (!result) {
        result = [self.defaultManager containerURLForSecurityApplicationGroupIdentifier:appGroupIdentifier];
    }
    BOOL isDirectory = NO;
    if (result && [self.defaultManager fileExistsAtPath:result.path isDirectory:&isDirectory]) {
        if (!isDirectory) {
            @throw NSInvalidArgumentException;
            return nil;
        }
        URLByAppGroupIdentifiers[appGroupIdentifier] = result;
    }
    
    if (result) {
        NSError *error = nil;
        [self.defaultManager createDirectoryAtPath:result.path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            @throw error;
        }
    }
    
    return result;
}

#pragma mark -

- (NSURL *)URLWithFilename:(NSString *)fn {
    return [self.defaultDirectory URLByAppendingPathComponent:fn];
}

- (NSURL *)URLWithFilename:(NSString *)fn extension:(NSString *)ext {
    return [self.defaultDirectory URLByAppendingFilename:fn extension:ext];
}

- (NSURL *)URLWithFilename:(NSString *)fn version:(NSString *)ver extension:(NSString *)ext {
    return [self.defaultDirectory URLByAppendingFilename:fn version:ver extension:ext];
}


@end


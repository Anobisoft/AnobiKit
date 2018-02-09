//
//  AKFileManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 09.02.2018.
//

#import "AKFileManager.h"

@implementation NSURL (AnobiKit)

- (NSURL *)fileURLWithName:(NSString *)fn {
    return [[self URLByAppendingPathComponent:fn] URLByAppendingPathExtension:@"dat"];
}
- (NSURL *)fileURLWithName:(NSString *)fn version:(NSUInteger)ver {
    return [self fileURLWithName:[NSString stringWithFormat:@"%@_v%lu", fn, (unsigned long)ver]];
}

@end

@implementation AKFileManager

#pragma mark -

+ (NSURL *)documentsURL {
    static NSURL *containerURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        containerURL = [[self defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
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
        tryURL = [[self defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGrId];
    }
    BOOL isDirectory = NO;
    if (tryURL && [[self defaultManager] fileExistsAtPath:tryURL.path isDirectory:&isDirectory] && isDirectory) {
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

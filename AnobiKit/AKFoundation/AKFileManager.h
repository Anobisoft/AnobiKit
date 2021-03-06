//
//  AKFileManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-02-09.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AnobiKit)

- (NSURL *)URLByAppendingFilename:(NSString *)fn extension:(NSString *)ext;
- (NSURL *)URLByAppendingFilename:(NSString *)fn version:(NSString *)ver extension:(NSString *)ext;

@end


@interface AKFileManager : NSFileManager

+ (instancetype)manager; // documents directory
+ (instancetype)resourcesManager;
+ (instancetype)managerWithDirectoryURL:(NSURL *)directory;

+ (NSURL *)documentsDirectoryURL; // Default
+ (NSURL *)mainBundleResourceURL;
+ (NSURL *)defaultAppGroupDirectoryURL;
+ (NSURL *)directoryURLWithAppGroup:(NSString *)appGroupIdentifier;

@property (nonatomic, readonly) NSURL *defaultDirectory;

- (NSURL *)URLWithFilename:(NSString *)fn;
- (NSURL *)URLWithFilename:(NSString *)fn extension:(NSString *)ext;
- (NSURL *)URLWithFilename:(NSString *)fn version:(NSString *)ver extension:(NSString *)ext;

@end



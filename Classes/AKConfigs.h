//
//  AKConfigs.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKConfigs : NSObject

+ (NSDictionary *)mainConfig;
+ (NSDictionary *)entitlements;
+ (NSString *)appGroupIdentifier;
+ (NSURL *)dataContainerURL;
+ (NSURL *)dataArchiveMain;
+ (NSURL *)dataFileURLWithName:(NSString *)fn;

+ (NSURL *)APIBaseURL;
+ (NSURL *)APIBaseURLTest;

+ (instancetype)shared;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (NSDictionary *)objectForKeyedSubscript:(NSString *)key;


@end

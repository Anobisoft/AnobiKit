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
+ (NSArray<NSString *> *)iCloudContainerIdentifiers;
+ (NSString *)appGroupIdentifier;
+ (NSURL *)dataContainerURL;
+ (NSURL *)dataFileURLWithName:(NSString *)fn;
+ (NSURL *)dataFileURLWithName:(NSString *)fn version:(NSUInteger)version;


+ (instancetype)shared;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (id)objectForKeyedSubscript:(NSString *)key;


@end

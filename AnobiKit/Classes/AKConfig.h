//
//  AKConfig.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKTypes.h"

@interface NSURL (AnobiKit)

- (NSURL *)fileURLWithName:(NSString *)fn;
- (NSURL *)fileURLWithName:(NSString *)fn version:(NSUInteger)version;

@end

#define AKConfigDefaultName @"AKMainConfig"

@interface AKConfig<__covariant CollectionType> : AKSingleton <KeyedSubscript>

- (CollectionType)objectForKeyedSubscript:(__kindof NSObject<NSCopying> *)cfgName;

+ (instancetype)configs;
+ (CollectionType)configWithName:(NSString *)name;

+ (NSURL *)documentsURL;
+ (NSURL *)documentsFileURLWithName:(NSString *)fn;
+ (NSURL *)documentsFileURLWithName:(NSString *)fn version:(NSUInteger)ver;

+ (NSURL *)containerWithAppGroupIdentifier:(NSString *)appGrId;
+ (NSURL *)sharedAppGroupIdentifier:(NSString *)appGrId fileURLWithName:(NSString *)fn;
+ (NSURL *)sharedAppGroupIdentifier:(NSString *)appGrId fileURLWithName:(NSString *)fn version:(NSUInteger)ver;

+ (NSURL *)defaultContainer;
+ (NSURL *)defaultDataFileURLWithName:(NSString *)fn; //shared as default
+ (NSURL *)defaultDataFileURLWithName:(NSString *)fn version:(NSUInteger)ver;


@end

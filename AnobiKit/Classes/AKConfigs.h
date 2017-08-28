//
//  AKConfigs.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AnobiKit)

- (NSURL *)fileURLWithName:(NSString *)fn;
- (NSURL *)fileURLWithName:(NSString *)fn version:(NSUInteger)version;

@end

#define AKConfigsDefaultName @"AKMainConfig"

@interface AKConfigs<__covariant CollectionType> : NSObject

+ (CollectionType)configWithName:(NSString *)name;
+ (instancetype)shared;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (CollectionType)objectForKeyedSubscript:(NSString *)key;

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

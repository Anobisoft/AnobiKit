//
//  AKFileManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 09.02.2018.
//

#import <Foundation/Foundation.h>

@interface NSURL (AnobiKit)

- (NSURL *)fileURLWithName:(NSString *)fn;
- (NSURL *)fileURLWithName:(NSString *)fn version:(NSUInteger)version;

@end


@interface AKFileManager : NSFileManager

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

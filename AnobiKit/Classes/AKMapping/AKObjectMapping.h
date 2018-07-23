//
//  AKObjectMapping.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//


#import <Foundation/Foundation.h>


#define AKObjectMap NSDictionary<NSString *, AKPropertyMap *>
#define AKMutableObjectMap NSMutableDictionary<NSString *, AKPropertyMap *>


@class AKPropertyMap;


@protocol AKObjectMapping

@required
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap;
+ (AKObjectMap *)objectMap;

@optional
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation;

@end



@protocol AKObjectReverseMapping

@required
- (NSDictionary *)keyedRepresentation;

@optional
@property (class, readonly) NSDateFormatter *defaultDateFormatter;
@property (class, readonly) NSDictionary<NSString *, NSDateFormatter *> *dateFormatters;
+ (NSString *)stringFromBoolean:(BOOL)b;
+ (NSString *)stringFromBoolean:(BOOL)b property:(NSString *)property;

@end


#import <AnobiKit/AKPropertyMap.h>
#import <AnobiKit/AKMappedObject.h>

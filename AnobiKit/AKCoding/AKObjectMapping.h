//
//  AKObjectMapping.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//


#import <Foundation/Foundation.h>

#ifndef AKObjectMapping_h
#define AKObjectMapping_h

@class AKPropertyMap;

#pragma mark -

@protocol AKObjectMapping

@required
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation
                                           objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;
+ (NSDictionary<NSString *, AKPropertyMap *> *)objectMap;

@optional
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation;

@end

#pragma mark -

@protocol AKObjectReverseMapping

@required
- (NSDictionary *)keyedRepresentation;

@optional
@property (class, readonly) NSDateFormatter *defaultDateFormatter;
@property (class, readonly) NSDictionary<NSString *, NSDateFormatter *> *dateFormatters;
+ (NSString *)stringFromBoolean:(BOOL)b;
+ (NSString *)stringFromBoolean:(BOOL)b property:(NSString *)property;

@end

#endif /* AKObjectMapping_h */

#import <AnobiKit/AKPropertyMap.h>
#import <AnobiKit/AKMappedObject.h>

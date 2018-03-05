//
//  AKMappedObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKCodableObject.h>
#import <AnobiKit/AKObjectMapping.h>

@interface AKMappedObject : AKCodableObject <AKObjectMapping, AKObjectReverseMapping>

@property (class) NSDateFormatter *defaultDateFormatter;
@property (class, readonly) NSDictionary<NSString *, NSDateFormatter *> *dateFormatters;
+ (NSString *)stringFromBoolean:(BOOL)b;
+ (NSString *)stringFromBoolean:(BOOL)b property:(NSString *)property;

@end

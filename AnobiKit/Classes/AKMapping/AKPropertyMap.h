//
//  AKPropertyMap.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKObjectMapping.h>

@interface AKPropertyMap : NSObject

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey;
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass;
+ (instancetype)mapWithObjectMap:(AKObjectMap *)objectMap;

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass;
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectMap:(AKObjectMap *)objectMap;
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(AKObjectMap *)objectMap;

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(AKObjectMap *)objectMap;


@property NSString *propertyKey;
@property Class<AKObjectMapping> objectClass;
@property AKObjectMap *objectMap;

@end

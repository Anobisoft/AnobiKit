//
//  AKPropertyMap.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-10-06.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKObjectMapping.h>

@interface AKPropertyMap : NSObject

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey;
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass;
+ (instancetype)mapWithObjectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass;
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;

@property (nonatomic) NSString *propertyKey;
@property (nonatomic) Class<AKObjectMapping> objectClass;
@property (nonatomic) NSDictionary<NSString *, AKPropertyMap *> *objectMap;

@end

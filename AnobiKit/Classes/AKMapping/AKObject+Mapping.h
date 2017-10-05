//
//  AKObject+Mapping.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKObject.h>

#define AKObjectMap NSDictionary<NSString *, AKPropertyMap *>
#define AKMutableObjectMap NSMutableDictionary<NSString *, AKPropertyMap *>

@class AKPropertyMap;

@protocol AKObjectMapping <NSObject>
@required
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation;
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap;
@optional
+ (AKObjectMap *)objectMap;
@end

@interface AKPropertyMap : NSObject
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey;
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(AKObjectMap *)objectMap;
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                          objectClass:(Class<AKObjectMapping>)objectClass
                            objectMap:(AKObjectMap *)objectMap;


@property NSString *propertyKey;
@property Class<AKObjectMapping> objectClass;
@property AKObjectMap *objectMap;
@end



@interface AKObject (Mapping) <AKObjectMapping>


@end

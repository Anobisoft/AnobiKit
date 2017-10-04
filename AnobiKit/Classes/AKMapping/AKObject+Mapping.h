//
//  AKObject+Mapping.h
//  Pods
//
//  Created by Stanislav Pletnev on 29.09.17.
//
//

#import <AnobiKit/AnobiKit.h>

#define AKObjectMap NSDictionary<NSString *, AKPropertyMap *>

@protocol AKObjectMapping;

@interface AKPropertyMap : NSObject
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                          objClass:(Class<AKObjectMapping>)objClass
                            objMap:(AKObjectMap *)objMap;
@property NSString *propertyKey;
@property Class<AKObjectMapping> objClass;
@property AKObjectMap *objMap;
@end

@protocol AKObjectMapping <NSObject>

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation mapping:(AKObjectMap *)mapping;

@end

@interface AKObject (Mapping) <AKObjectMapping>


@end

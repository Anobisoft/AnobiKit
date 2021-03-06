//
//  AKPropertyMap.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-10-06.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKPropertyMap.h"

@implementation AKPropertyMap

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey {
    return [self mapWithPropertyKey:propertyKey objectClass:nil objectMap:nil];
}

+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass {
    return [self mapWithPropertyKey:nil objectClass:objectClass objectMap:nil];
}

+ (instancetype)mapWithObjectMap:(NSDictionary<NSString *,AKPropertyMap *> *)objectMap {
    return [self mapWithPropertyKey:nil objectClass:nil objectMap:objectMap];
}

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass {
    return [self mapWithPropertyKey:propertyKey objectClass:objectClass objectMap:nil];
}
+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                         objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    return [self mapWithPropertyKey:propertyKey objectClass:nil objectMap:objectMap];
}
+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
	return [self mapWithPropertyKey:nil objectClass:objectClass objectMap:objectMap];
}

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    
    return [[self alloc] initWithPropertyKey:propertyKey
                                 objectClass:objectClass
                                   objectMap:objectMap];
}

- (instancetype)initWithPropertyKey:(NSString *)propertyKey
                        objectClass:(Class<AKObjectMapping>)objectClass
                          objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    if (self = [self init]) {
        self.propertyKey = propertyKey;
        self.objectClass = objectClass;
        self.objectMap = objectMap;
    }
    return self;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@ propertyKey:%@, objectClass:%@, objectMapKeys:%@", super.description, self.propertyKey, self.objectClass, self.objectMap.allKeys];
}

@end

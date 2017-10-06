//
//  AKPropertyMap.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKPropertyMap.h"

@implementation AKPropertyMap

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey {
    return [[self alloc] initWithPropertyKey:propertyKey
                                 objectClass:nil
                                   objectMap:nil];
}

+ (instancetype)mapWithObjectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(NSDictionary<NSString *,AKPropertyMap *> *)objectMap {
    return [[self alloc] initWithPropertyKey:nil
                                 objectClass:objectClass
                                   objectMap:objectMap];
}

+ (instancetype)mapWithPropertyKey:(NSString *)propertyKey
                       objectClass:(Class<AKObjectMapping>)objectClass
                         objectMap:(AKObjectMap *)objectMap {
    return [[self alloc] initWithPropertyKey:propertyKey
                                 objectClass:objectClass
                                   objectMap:objectMap];
}

- (instancetype)initWithPropertyKey:(NSString *)propertyKey
                        objectClass:(Class<AKObjectMapping>)objectClass
                          objectMap:(AKObjectMap *)objectMap {
    if (self = [super init]) {
        self.propertyKey = propertyKey;
        self.objectClass = objectClass;
        self.objectMap = objectMap;
    }
    return self;
}

@end

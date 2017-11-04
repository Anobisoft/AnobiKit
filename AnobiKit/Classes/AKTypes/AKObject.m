//
//  AKObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKObject.h"
#import <objc/runtime.h>

id AKDeepCopy(id object) {
    if ([object conformsToProtocol:@protocol(AKDeepCopying)]) {
        id<AKDeepCopying> deepReady = (id<AKDeepCopying>)object;
        return deepReady.deepcopy;
    }
    
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        id<NSCopying>copyReady = (id<NSCopying>)object;
        return [copyReady copyWithZone:nil];
    }
    
    return object;
}

@implementation NSDictionary(AKDeepCopying)

- (instancetype)deepcopy {
    NSMutableDictionary *mutable = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        mutable[key] = AKDeepCopy(obj);
    }];
    return mutable.copy;
}

@end

@implementation NSArray(AKDeepCopying)

- (instancetype)deepcopy {
    NSMutableArray *mutable = [NSMutableArray new];
    for (id obj in self) {
        [mutable addObject:AKDeepCopy(obj)];
    }
    return mutable.copy;
}

@end

@implementation NSSet(AKDeepCopying)

- (instancetype)deepcopy {
    NSMutableSet *mutable = [NSMutableSet new];
    for (id obj in self) {
        [mutable addObject:AKDeepCopy(obj)];
    }
    return mutable.copy;
}

@end

@implementation AKObject

static NSDictionary <Class, NSArray<NSString *> *> *serializableProperties;

+ (BOOL)supportsSecureCoding {
    return true;
}

+ (NSArray<NSString *> *)propertyExclusions {
    return nil;
}

+ (void)initialize {
    [super initialize];

    NSMutableArray<NSString *> *serializablePropertiesM = [NSMutableArray new];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        unsigned int attrCount = 0;
        objc_property_attribute_t *propertyAttributeList = property_copyAttributeList(properties[i], &attrCount);
        unsigned int j;
        for (j = 0; j < attrCount; j++) {
            if (!strcmp(propertyAttributeList[j].name, "R")) break;
        }
        if (j == attrCount) {
            NSString *propertyKey = [NSString stringWithUTF8String:property_getName(properties[i])];
            if ( !([self propertyExclusions] && [[self propertyExclusions] containsObject:propertyKey]) ) {
                [serializablePropertiesM addObject:propertyKey];
            }
        }
        free(propertyAttributeList);
    }
    if (serializablePropertiesM.count) {
        NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:serializableProperties];
        mutable[(id <NSCopying>)self] = serializablePropertiesM.copy;
        serializableProperties = mutable.copy;
    }
    
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        for (NSString *propertyKey in self.serializableProperties) {
            [self setValue:[aDecoder decodeObjectForKey:propertyKey] forKey:propertyKey];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    for (NSString *propertyKey in self.serializableProperties) {
        [aCoder encodeObject:[self valueForKey:propertyKey] forKey:propertyKey];
    }
}

- (NSString *)description {
    NSMutableDictionary *properties = [NSMutableDictionary new];
    
    for (NSString *propertyKey in self.serializableProperties) {
        properties[propertyKey] = [self valueForKey:propertyKey] ?: @"nil";
    }
    
    return [NSString stringWithFormat:@"%@ %@", [super description], properties.copy];
}

- (NSArray<NSString *> *)serializableProperties {
    return self.class.serializableProperties;
}

+ (NSArray<NSString *> *)serializableProperties {
    Class superclass = [self superclass];
    if (superclass == [AKObject class]) {
        return serializableProperties[self];
    } else {
        return [serializableProperties[self] arrayByAddingObjectsFromArray:superclass.serializableProperties];
    }
}

- (BOOL)isEqual:(id)object {
    for (NSString *key in self.serializableProperties) {
        id svalue = [self valueForKey:key];
        id ovalue = [object valueForKey:key];
        if (svalue && ![svalue isEqual:ovalue]) {
            return false;
        }
    }
    return true;
}

- (BOOL)isEmpty {
    for (NSString *key in self.serializableProperties) {
        id value = [self valueForKey:key];
        if (value) {
            return false;
        }
    }
    return true;
}

+ (BOOL)mergeObject:(AKObject *)a toObject:(AKObject *)b {
    if (![b isKindOfClass:a.class]) {
        @throw NSInternalInconsistencyException;
    }
    BOOL haschanged = false;
    for (NSString *key in a.serializableProperties) {
        id value = [b valueForKey:key];
        if (!value) { //field is empty
            id newValue = [a valueForKey:key];
            [b setValue:newValue forKey:key];
            haschanged = true;
        }
    }
    return haschanged;
}

- (BOOL)mergeToObject:(AKObject *)obj {
    return [self.class mergeObject:self toObject:obj];
}

- (BOOL)mergeFromObject:(AKObject *)obj {
    return [self.class mergeObject:obj toObject:self];
}

- (instancetype)copy {
    id newinstance = [self.class new];
    for (NSString *key in self.serializableProperties) {
        NSObject *object = [self valueForKey:key];
        [newinstance setValue:object.copy forKey:key];
    }
    return newinstance;
}

- (instancetype)deepcopy {
    id newinstance = [self.class new];
    for (NSString *key in self.serializableProperties) {
        id value = [self valueForKey:key];
        [newinstance setValue:AKDeepCopy(value) forKey:key];
    }
    return newinstance;
}

@end

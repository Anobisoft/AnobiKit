//
//  AKCodableObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKCodableObject.h"
#import <objc/runtime.h>

id AKDeepCopy(id object) {
    if ([object conformsToProtocol:@protocol(AKDeepCopying)]) {
        return [(id<AKDeepCopying>)object deepcopy];
    }
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        return [(id<NSCopying>)object copyWithZone:nil];
    }
    return object;
}

@interface NSDictionary(AKDeepCopying) <AKDeepCopying> @end
@implementation NSDictionary(AKDeepCopying)
- (instancetype)deepcopy {
    NSMutableDictionary *mutable = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        mutable[key] = AKDeepCopy(obj);
    }];
    return mutable.copy;
}
@end

@interface NSArray(AKDeepCopying) <AKDeepCopying> @end
@implementation NSArray(AKDeepCopying)
- (instancetype)deepcopy {
    NSMutableArray *mutable = [NSMutableArray new];
    for (id obj in self) {
        [mutable addObject:AKDeepCopy(obj)];
    }
    return mutable.copy;
}
@end

@interface NSSet(AKDeepCopying) <AKDeepCopying> @end
@implementation NSSet(AKDeepCopying)
- (instancetype)deepcopy {
    NSMutableSet *mutable = [NSMutableSet new];
    for (id obj in self) {
        [mutable addObject:AKDeepCopy(obj)];
    }
    return mutable.copy;
}
@end

@implementation AKCodableObject

+ (BOOL)supportsSecureCoding {
    return true;
}

static NSMutableDictionary <Class, NSArray<NSString *> *> *writablePropertiesByClass;
static NSMutableDictionary <Class, NSArray<NSString *> *> *readonlyPropertiesByClass;

BOOL readonly(const char * attrs) {
    size_t l = strlen(attrs);
    for (size_t i = 0; i < l; i++) {
        if (attrs[i] == 'R') return true;
    }
    return false;
}

+ (void)initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        writablePropertiesByClass = [NSMutableDictionary new];
        readonlyPropertiesByClass = [NSMutableDictionary new];
    });

    NSMutableArray *rwProperties = [NSMutableArray new];
    NSMutableArray *roProperties = [NSMutableArray new];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        NSString *propertyKey = [NSString stringWithUTF8String:property_getName(properties[i])];
        const char * attrs = property_getAttributes(properties[i]);
        if (readonly(attrs)) {
            [roProperties addObject:propertyKey];
        } else {
            [rwProperties addObject:propertyKey];
        }
    }
    if (rwProperties.count) {
        writablePropertiesByClass[(id<NSCopying>)self] = rwProperties.copy;
    }
    if (roProperties.count) {
        readonlyPropertiesByClass[(id<NSCopying>)self] = roProperties.copy;
    }
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        for (NSString *propertyKey in self.writableProperties) {
            [self setValue:[aDecoder decodeObjectForKey:propertyKey] forKey:propertyKey];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    for (NSString *propertyKey in self.writableProperties) {
        id obj = [self valueForKey:propertyKey];
        if ([obj conformsToProtocol:@protocol(NSSecureCoding)]) {
            [aCoder encodeObject:obj forKey:propertyKey];
        }
    }
}

- (NSString *)description {
    NSMutableDictionary *properties = [NSMutableDictionary new];
    for (NSString *propertyKey in self.writableProperties) {
        properties[propertyKey] = [self valueForKey:propertyKey] ?: @"nil";
    }
    for (NSString *propertyKey in self.readonlyProperties) {
        properties[propertyKey] = [self valueForKey:propertyKey] ?: @"nil";
    }
    return [NSString stringWithFormat:@"%@ %@", [super description], properties];
}

- (NSArray<NSString *> *)writableProperties {
    return self.class.writableProperties;
}

+ (NSArray<NSString *> *)writableProperties {
    Class superclass = [self superclass];
    if (superclass == [AKCodableObject class]) {
        return writablePropertiesByClass[self];
    } else {
        return [writablePropertiesByClass[self] arrayByAddingObjectsFromArray:superclass.writableProperties];
    }
}

- (NSArray<NSString *> *)readonlyProperties {
    return self.class.readonlyProperties;
}

+ (NSArray<NSString *> *)readonlyProperties {
    Class superclass = [self superclass];
    if (superclass == [AKCodableObject class]) {
        return readonlyPropertiesByClass[self];
    } else {
        return [readonlyPropertiesByClass[self] arrayByAddingObjectsFromArray:superclass.readonlyProperties];
    }
}

- (NSArray<NSString *> *)readableProperties {
    return self.class.readableProperties;
}

+ (NSArray<NSString *> *)readableProperties {
    if (self.writableProperties.count && self.readonlyProperties.count) {
        return [self.writableProperties arrayByAddingObjectsFromArray:self.readonlyProperties];
    }
    return self.writableProperties.count ? self.writableProperties : self.readonlyProperties;
}

- (BOOL)isEqual:(id)object {
    for (NSString *key in self.readableProperties) {
        id svalue = [self valueForKey:key];
        id ovalue = [object valueForKey:key];
        if (svalue && ovalue) {
            if (![svalue isEqual:ovalue]) return false;
        } else {
            if (svalue || ovalue) return false;
        }
    }
    return true;
}

- (BOOL)isEmpty {
    for (NSString *key in self.readableProperties) {
        id value = [self valueForKey:key];
        if (value) {
            return false;
        }
    }
    return true;
}

+ (BOOL)mergeObject:(__kindof AKCodableObject *)a toObject:(__kindof AKCodableObject *)b {
    if (![b isKindOfClass:a.class]) {
        @throw NSInternalInconsistencyException;
    }
    BOOL haschanged = false;
    for (NSString *key in a.writableProperties) {
        id value = [b valueForKey:key];
        if (!value) { //field is empty
            id newValue = [a valueForKey:key];
            [b setValue:newValue forKey:key];
            haschanged = true;
        }
    }
    return haschanged;
}

- (BOOL)mergeToObject:(__kindof AKCodableObject *)obj {
    return [self.class mergeObject:self toObject:obj];
}

- (BOOL)mergeFromObject:(__kindof AKCodableObject *)obj {
    return [self.class mergeObject:obj toObject:self];
}

- (instancetype)copy {
    return self.deepcopy;
}

- (instancetype)deepcopy {
    id newinstance = [self.class new];
    for (NSString *key in self.writableProperties) {
        id value = [self valueForKey:key];
        [newinstance setValue:AKDeepCopy(value) forKey:key];
    }
    return newinstance;
}

@end

//
//  AKCodableObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKCodableObject.h"
#import <objc/runtime.h>
#import <AnobiKit/AKDeepCopyingUtilities.h>
#import <AnobiKit/NSObject+Identification.h>


@implementation AKCodableObject

+ (BOOL)supportsSecureCoding {
    return true;
}

static NSMutableDictionary <NSString *, NSArray<NSString *> *> *AKCodableObject_writablePropertiesByClass;
static NSMutableDictionary <NSString *, NSArray<NSString *> *> *AKCodableObject_readonlyPropertiesByClass;

BOOL readonly(const char * attrs) {
    size_t l = strlen(attrs);
    for (size_t i = 0; i < l; i++) {
        if (attrs[i] == 'R'
            && (i == 0 || attrs[i-1] == ',') // prev symbol is separator
            && (i+1 == l || attrs[i+1] == ',') // next symbol is separator
            ) return true;
    }
    return false;
}

+ (void)load {
    AKCodableObject_writablePropertiesByClass = [NSMutableDictionary new];
    AKCodableObject_readonlyPropertiesByClass = [NSMutableDictionary new];
}

+ (void)initialize {
    [super initialize];
    if (self == AKCodableObject.class) return;    
    
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
        AKCodableObject_writablePropertiesByClass[self.classIdentifier] = rwProperties.copy;
    }
    if (roProperties.count) {
        AKCodableObject_readonlyPropertiesByClass[self.classIdentifier] = roProperties.copy;
    }
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
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
    properties[@" --- "] = @"readonly";
    for (NSString *propertyKey in self.readonlyProperties) {
        properties[propertyKey] = [self valueForKey:propertyKey] ?: @"nil";
    }
    properties[@" --- "] = @"readwrite";
    for (NSString *propertyKey in self.writableProperties) {
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
        return AKCodableObject_writablePropertiesByClass[self.classIdentifier];
    }
    NSArray<NSString *> *selfrwp = AKCodableObject_writablePropertiesByClass[self.classIdentifier];
    NSArray<NSString *> *superwp = superclass.writableProperties;
    return selfrwp ? [selfrwp arrayByAddingObjectsFromArray:superwp] : superwp;
}

- (NSArray<NSString *> *)readonlyProperties {
    return self.class.readonlyProperties;
}

+ (NSArray<NSString *> *)readonlyProperties {
    Class superclass = [self superclass];
    if (superclass == [AKCodableObject class]) {
        return AKCodableObject_readonlyPropertiesByClass[self.classIdentifier];
    }
    NSArray<NSString *> *selfrop = AKCodableObject_readonlyPropertiesByClass[self.classIdentifier];
    NSArray<NSString *> *superop = superclass.readonlyProperties;
    return selfrop ? [selfrop arrayByAddingObjectsFromArray:superop] : superop;
}

- (NSArray<NSString *> *)readableProperties {
    return self.class.readableProperties;
}

+ (NSArray<NSString *> *)readableProperties {
    NSArray<NSString *> *selfrop = self.readonlyProperties;
    NSArray<NSString *> *selfrwp = self.writableProperties;
    if (selfrop.count && selfrwp.count) {
        return [selfrop arrayByAddingObjectsFromArray:selfrwp];
    }
    return selfrop.count ? selfrop : selfrwp;
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

+ (BOOL)complementObject:(__kindof AKCodableObject *)a withObject:(__kindof AKCodableObject *)b {
    if (![b isKindOfClass:a.class]) {
        @throw NSInternalInconsistencyException;
    }
    BOOL haschanged = false;
    for (NSString *key in a.writableProperties) {
        id value = [a valueForKey:key];
        if (!value) { // field is empty
            value = [b valueForKey:key];
            [a setValue:value forKey:key];
            haschanged = true;
        }
    }
    return haschanged;
}

- (BOOL)complementObject:(__kindof AKCodableObject *)obj {
    return [self.class complementObject:obj withObject:self];
}

- (BOOL)complementWithObject:(__kindof AKCodableObject *)obj {
    return [self.class complementObject:self withObject:obj];
}

- (instancetype)copy {
    return self.deepcopy;
}

- (id)mutableCopy {
    return self.deepcopy;
}

- (instancetype)deepcopy {
    typeof(self) newinstance = [self.class new];
    for (NSString *key in self.writableProperties) {
        id value = [self valueForKey:key];
        [newinstance setValue:AKMakeDeepCopy(value) forKey:key];
    }
    return newinstance;
}

@end

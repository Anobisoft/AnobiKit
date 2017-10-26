//
//  AKObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKObject.h"
#import <objc/runtime.h>

@protocol AKObjectDeepcopy
- (instancetype)deepcopy;
@end

@interface NSArray(Deepcopy) <AKObjectDeepcopy>
@end

@interface NSDictionary(Deepcopy) <AKObjectDeepcopy>
@end

@implementation NSArray(Deepcopy)

- (instancetype)deepcopy {
    NSMutableArray *mutable = [NSMutableArray new];
    for (NSObject *object in self) {
        if ([object conformsToProtocol:@protocol(AKObjectDeepcopy)]) {
            [mutable addObject:((id<AKObjectDeepcopy>)object).deepcopy];
        } else {
            [mutable addObject:object.copy];
        }
    }
    return mutable.copy;
}

@end

@implementation NSDictionary(Deepcopy)

- (instancetype)deepcopy {
    NSMutableDictionary *mutable = [NSMutableDictionary new];
    for (NSObject<NSCopying> *key in self.allKeys) {
        if ([self[key] conformsToProtocol:@protocol(AKObjectDeepcopy)]) {
            [mutable setObject:((id<AKObjectDeepcopy>)self[key]).deepcopy forKey:key];
        } else {
            [mutable setObject:((NSObject *)self[key]).copy forKey:key];
        }
    }
    return mutable.copy;
}

@end


@implementation AKObject {
    
}

static NSDictionary <Class, NSArray<NSString *> *> *serializableProperties;

+ (BOOL)supportsSecureCoding {
    return true;
}

+ (NSSet<NSString *> *)propertyExclusions {
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
        Class superClass = [self class];
        while (superClass != [AKObject class]) {
            for (NSString *propertyKey in superClass.serializableProperties) {
                [self setValue:[aDecoder decodeObjectForKey:propertyKey] forKey:propertyKey];
            }
            superClass = [superClass superclass];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    Class superClass = [self class];
    while (superClass != [AKObject class]) {
        for (NSString *propertyKey in superClass.serializableProperties) {
            [aCoder encodeObject:[self valueForKey:propertyKey] forKey:propertyKey];
        }
        superClass = [superClass superclass];
    }
}

- (NSString *)description {
    NSMutableDictionary *properties = [NSMutableDictionary new];
    
    Class superClass = [self class];
    while (superClass != [AKObject class]) {
        for (NSString *propertyKey in superClass.serializableProperties) {
            [properties setValue:[self valueForKey:propertyKey] ?: @"nil" forKey:propertyKey];
        }
        superClass = [superClass superclass];
    }
    

    
    return [NSString stringWithFormat:@"%@ %@", [super description], properties.copy];
}

- (NSArray<NSString *> *)serializableProperties {
    return serializableProperties[self.class];
}

+ (NSArray<NSString *> *)serializableProperties {
    return serializableProperties[self];
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
        id value = [self valueForKey:key];
        if ([value conformsToProtocol:@protocol(AKObjectDeepcopy)]) {
            [newinstance setValue:((id<AKObjectDeepcopy>)value).deepcopy forKey:key];
        } else {
            NSObject *object = value;
            [newinstance setValue:object.copy forKey:key];
        }
    }
    return newinstance;
}


@end

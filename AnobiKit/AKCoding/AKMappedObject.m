//
//  AKMappedObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//


#import "AKMappedObject.h"
#import "NSUUID+AnobiKit.h"
@import ObjectiveC.runtime;

@implementation AKMappedObject

#pragma mark - AKObjectMapping

+ (NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    return nil;
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation {
    return [self instatiateWithExternalRepresentation:representation objectMap:nil];
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation
                                           objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    
    NSDictionary<NSString *, AKPropertyMap *> *selfMap = objectMap ?: [self objectMap];
    if ([representation isKindOfClass:NSArray.class] || [representation isKindOfClass:NSSet.class]) {
        AKPropertyMap *itemMap = [AKPropertyMap mapWithObjectClass:self objectMap:selfMap];
        return [self collectionWithExternalRepresentation:representation withClass:representation.class propertyMap:itemMap];
    }
    return [[self alloc] initWithExternalRepresentation:representation objectMap:selfMap];
}

- (instancetype)initWithExternalRepresentation:(NSDictionary *)representation
                                     objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap {
    
    if ([representation isKindOfClass:NSNull.class]) {
        return nil;
    }
    if (self = [self init]) {
        [representation enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *propertyKey = key;
            AKPropertyMap *propertyMap = objectMap[key];
            if (propertyMap.propertyKey) {
                propertyKey = propertyMap.propertyKey;
            }
            [self mapExternalRepresentation:obj forKey:propertyKey propertyMap:propertyMap];
        }];
    }
    return self;
}

- (void)mapExternalRepresentation:(id)obj
                           forKey:(NSString *)propertyKey
                      propertyMap:(AKPropertyMap *)propertyMap {
    
    objc_property_t property = class_getProperty(object_getClass(self), [propertyKey UTF8String]);
    if (!property) {
        NSLog(@"[WARNING] %@ map: representation keyed '%@' skipped: setter not found.", self.class, propertyKey);
        return ;
    }
    Class mapClass = propertyMap.objectClass;
    Class propertyClass = property_getClass(property);
    if (mapClass) {
        NSAssert([mapClass conformsToProtocol:@protocol(AKObjectMapping)], @"class [%@] in map [%@] must conformsToProtocol <AKObjectMapping>", mapClass, propertyMap);
        if ([obj conformsToProtocol:@protocol(NSFastEnumeration)]) {
            NSAssert([propertyClass isSubclassOfClass:NSArray.class] || [propertyClass isSubclassOfClass:NSSet.class], @"Property class [%@] must be subclass of class NSArray (or NSSet), since external representation is NSFastEnumeration type [%@] (propertyMap %@)", propertyClass, ((NSObject *)obj).class, propertyMap.debugDescription);
            id collection = [self.class collectionWithExternalRepresentation:obj withClass:propertyClass propertyMap:propertyMap];
            [self try2setObject:collection forKey:propertyKey];
        } else {
            id newPropertyInstance = [mapClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
            [self try2setObject:newPropertyInstance forKey:propertyKey];
        }
    } else {  //automap
        [self automapExternalRepresentation:obj forKey:propertyKey propertyClass:propertyClass propertyMap:propertyMap];
    }
}

+ (id)collectionWithExternalRepresentation:(id<NSObject, NSFastEnumeration>)obj
                                 withClass:(Class)collectionClass
                               propertyMap:(AKPropertyMap *)propertyMap {
    
    if (![collectionClass isSubclassOfClass:NSArray.class] && ![collectionClass isSubclassOfClass:NSSet.class]) {
        collectionClass = obj.class;
    }
    BOOL targetMutable = [collectionClass instancesRespondToSelector:@selector(addObject:)];
    NSMutableArray *collection = [collectionClass new];
    if (!targetMutable) {
        collection = collection.mutableCopy;
    }
    Class mapClass = propertyMap.objectClass;
    for (NSDictionary *objRepresentation in obj) {
        id newPropertyInstance = [mapClass instatiateWithExternalRepresentation:objRepresentation objectMap:propertyMap.objectMap];
        if (newPropertyInstance) { // skip NSNull
            [collection addObject:newPropertyInstance];
        }
    }
    if (!targetMutable) collection = collection.copy;
    return collection;
}

- (void)automapExternalRepresentation:(id)obj
                               forKey:(NSString *)propertyKey
                        propertyClass:(Class)propertyClass
                          propertyMap:(AKPropertyMap *)propertyMap {
    
    if (propertyClass) {
        if ([propertyClass conformsToProtocol:@protocol(AKObjectMapping)]) {
            id newPropertyInstance = [propertyClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
            [self try2setObject:newPropertyInstance forKey:propertyKey];
            return ;
        }
        if ([obj isKindOfClass:NSString.class]) {
            if ([propertyClass isSubclassOfClass:NSDate.class]) {
                NSDateFormatter *df = self.class.dateFormatters[propertyKey] ?: self.class.defaultDateFormatter;
                if (df) {
                    [self try2setObject:[df dateFromString:obj] forKey:propertyKey];
                    return ;
                }
            } else {
                if ([propertyClass isSubclassOfClass:NSURL.class]) {
                    [self try2setObject:[NSURL URLWithString:obj] forKey:propertyKey];
                    return ;
                }
                if ([propertyClass isSubclassOfClass:NSUUID.class]) {
                    [self try2setObject:[NSUUID UUIDWithString:obj] forKey:propertyKey];
                    return ;
                }
            }
        }
    }
    [self try2setObject:obj forKey:propertyKey]; // try to set representation object to property as is (JSON object representation)
}

Class property_getClass(objc_property_t property) {
    if (!property) return nil;
    char *type = property_copyAttributeValue(property, "T");
    unsigned long len = strlen(type);
    if (type[0] == '@' && len > 3) {
        unsigned long classstrlen;
        for (classstrlen = 0; ; classstrlen++) {
            char l = type[classstrlen+2];
            if (l == '"' || l == '<') break;
        }
        if (classstrlen > 0) {
            char objtypestr[classstrlen+1];
            memcpy(objtypestr, type+2, classstrlen);
            objtypestr[classstrlen] = '\0';
            NSString *className = [NSString stringWithUTF8String:objtypestr];
            free(type);
            return NSClassFromString(className);
        }
    }
    free(type);
    return nil;
}

- (void)try2setObject:(id)object forKey:(NSString *)key {
    @try {
        if ([object isKindOfClass:[NSNull class]]) {
            [self setValue:nil forKey:key];
        } else {
            [self setValue:object forKey:key];
        }
    } @catch (NSException *exception) {
        NSLog(@"[ERROR] exception: %@", exception);
    }
}

#pragma mark - AKObjectReverseMapping

id AKObjectReverseMappingRepresentation(id object) {
    if ([object conformsToProtocol:@protocol(AKObjectReverseMapping)]) {
        return ((id<AKObjectReverseMapping>)object).keyedRepresentation;
    }
    return object;
}

+ (NSDictionary<NSString *, NSDateFormatter *> *)dateFormatters {
    return nil;
}

static Class __NSCFBooleanClass = nil;
+ (void)load {
    __NSCFBooleanClass = NSClassFromString(@"__NSCFBoolean");
}

+ (NSDateFormatter *)defaultDateFormatter {
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    return df;
}

+ (NSString *)stringFromBoolean:(BOOL)b {
    return b ? @"true" : @"false";
}

+ (NSString *)stringFromBoolean:(BOOL)b property:(NSString *)property {
    return nil;
}

BOOL AKBoolValue(id obj) {
    NSNumber *number = obj;
    return number.boolValue;
}

- (NSDictionary *)keyedRepresentation {
    NSMutableDictionary *representation = [NSMutableDictionary new];
    for (NSString *key in self.readableProperties) {
        NSObject *value = [self valueForKey:key];
        if (!value) continue;
        value = AKObjectReverseMappingRepresentation(value);
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *origin = (NSDictionary *)value;
            NSMutableDictionary *mutable = [NSMutableDictionary new];
            [origin enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                mutable[key] = AKObjectReverseMappingRepresentation(obj);
            }];
            value = mutable;
        } else if ([value conformsToProtocol:@protocol(NSFastEnumeration)]) {
            NSMutableArray *mutable = [NSMutableArray new];
            id<NSFastEnumeration> enumeratable = (id<NSFastEnumeration>)value;
            for (id item in enumeratable) {
                [mutable addObject:AKObjectReverseMappingRepresentation(item)];
            }
            value = mutable;
        } else if ([value isKindOfClass:[NSDate class]]) {
            NSDateFormatter *df = self.class.dateFormatters[key] ?: self.class.defaultDateFormatter;
            if (df) {
                value = [df stringFromDate:(NSDate *)value];
            }
        } else if ([value isKindOfClass:__NSCFBooleanClass]) {
            BOOL b = AKBoolValue(value);
            value = [self.class stringFromBoolean:b property:key] ?: [self.class stringFromBoolean:b];
        }
        [representation setValue:value forKey:key];
    }
    return representation;
}

@end

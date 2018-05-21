//
//  AKMappedObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

@protocol AKMutable

- (void)addObject:(id)object;

@end


#import "AKMappedObject.h"
#import "AKUUID.h"
@import ObjectiveC.runtime;

@implementation AKMappedObject

+ (AKObjectMap *)objectMap {
    return nil;
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation {
    return [self instatiateWithExternalRepresentation:representation objectMap:nil];
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap {
    AKObjectMap *selfMap = objectMap ?: [self objectMap];
    return [[self alloc] initWithExternalRepresentation:representation objectMap:selfMap];
}

- (instancetype)initWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap {
    if (self = [super init]) {
        if ([representation isKindOfClass:NSNull.class]) {
            return nil;
        }
        if (![representation isKindOfClass:NSDictionary.class]) {
            return nil;
        }
        [representation enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *propertyKey = key;
            AKPropertyMap *propertyMap = objectMap[key];
            if (propertyMap) propertyKey = propertyMap.propertyKey ?: key;
            objc_property_t property = class_getProperty(object_getClass(self), [propertyKey UTF8String]);
            if (!property) {
                NSLog(@"[WARNING] Representation keyed '%@' skipped: setter not found.", propertyKey);
                return ;
            }
            Class propertyClass = property_getClass(property);
            Class mapClass = propertyMap.objectClass;
            if (mapClass) {
                if ([mapClass conformsToProtocol:@protocol(AKObjectMapping)]) {
                    if ([obj conformsToProtocol:@protocol(NSFastEnumeration)]) {
                        if (![propertyClass isSubclassOfClass:NSArray.class] && ![propertyClass isSubclassOfClass:NSSet.class]) {
                            @throw [NSException exceptionWithName:@"AKPropertyMapException"
                                                           reason:@"object representation conformsToProtocol NSFastEnumeration, but property class is not subclassOfClass NSArray or NSSet"
                                                         userInfo:@{ @"objectMap" : objectMap,
                                                                     @"key" : key,
                                                                     @"representation" : representation,
                                                                     @"propertyClass" : propertyClass,
                                                                     }];
                            return ;
                        }
                        BOOL targetMutable = [propertyClass instancesRespondToSelector:@selector(addObject:)];
                        NSMutableSet *mutableContainer = [propertyClass new];
                        if (!targetMutable) mutableContainer = mutableContainer.mutableCopy;
                        for (NSDictionary *objRepresentation in obj) {
                            id newPropertyInstance = [mapClass instatiateWithExternalRepresentation:objRepresentation objectMap:propertyMap.objectMap];
                            if (newPropertyInstance) {
                                [mutableContainer addObject:newPropertyInstance];
                            }
                        }
                        if (!targetMutable) mutableContainer = mutableContainer.copy;
                        [self try2setObject:mutableContainer forKey:propertyKey];
                    } else {
                        id newPropertyInstance = [mapClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
                        [self try2setObject:newPropertyInstance forKey:propertyKey];
                    }
                } else {
                    @throw [NSException exceptionWithName:@"AKPropertyMapException"
                                                   reason:@"propertyMap.objectClass not conformsToProtocol <AKObjectMapping>"
                                                 userInfo:@{ @"objectMap" : objectMap,
                                                             @"key" : key,
                                                             @"propertyMap" : propertyMap,
                                                             @"propertyMap.objectClass" : propertyMap.objectClass }];
                }
            } else {  //automap
                if (propertyClass) {
                    if ([propertyClass conformsToProtocol:@protocol(AKObjectMapping)]) {
                        id newPropertyInstance = [propertyClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
                        [self try2setObject:newPropertyInstance forKey:propertyKey];
                        return ;
                    }
                    if ([obj isKindOfClass:NSString.class]) {
                        if ([propertyClass isSubclassOfClass:NSDate.class]) {
                            NSDateFormatter *df = self.class.dateFormatters[key] ?: self.class.defaultDateFormatter;
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
                                [self try2setObject:[AKUUID UUIDWithUUIDString:obj] forKey:propertyKey];
                                return ;
                            }
                        }
                    }
                }
                [self try2setObject:obj forKey:propertyKey]; // try to set representation object to property as is (JSON object representation)
            }
            
        }];
    }
    return self;
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
+ (void)initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __NSCFBooleanClass = NSClassFromString(@"__NSCFBoolean");
    });
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

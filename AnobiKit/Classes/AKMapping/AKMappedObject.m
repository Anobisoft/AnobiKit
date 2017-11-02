//
//  AKMappedObject.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKMappedObject.h"
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
        [representation enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (!obj) return ;
            if ([obj isKindOfClass:[NSNull class]]) return ;
            NSString *propertyKey = key;
            AKPropertyMap *propertyMap = objectMap[key];
            if (propertyMap) propertyKey = propertyMap.propertyKey ?: key;
            Class objectClass = propertyMap.objectClass;
            if (objectClass && [objectClass conformsToProtocol:@protocol(AKObjectMapping)]) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSMutableArray *mutableArray = [NSMutableArray new];
                    for (NSDictionary *objRepresentation in obj) {
                        id newPropertyInstance = [propertyMap.objectClass instatiateWithExternalRepresentation:objRepresentation objectMap:propertyMap.objectMap];
                        [mutableArray addObject:newPropertyInstance];
                    }
                    [self setValue:mutableArray.copy forKey:propertyKey];
                } else {
                    id newPropertyInstance = [propertyMap.objectClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
                    [self setValue:newPropertyInstance forKey:propertyKey];
                }
            } else {  //automap
                objc_property_t property = class_getProperty(object_getClass(self), [propertyKey UTF8String]);
                if (property) {
                    Class propertyClass = [self classOfProperty:property];
                    if (propertyClass && [propertyClass conformsToProtocol:@protocol(AKObjectMapping)]) {
                        id newPropertyInstance = [propertyClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
                        [self setValue:newPropertyInstance forKey:propertyKey];
                    } else {
                        [self try2setObject:obj forKey:propertyKey]; // try to set representation object to property as is (JSON object representation)
                    }
//                    free(property);
                } else {
                    NSLog(@"[WARNING] Representation keyed '%@' skipped: setter not found.", propertyKey);
                }
            }
        }];
    }
    return self;
}

- (Class)classOfProperty:(objc_property_t)property {
    char *type = property_copyAttributeValue(property, "T");
    unsigned long len = strlen(type);
    switch (type[0]) {
        case '@': {
            if (len > 3) {
                unsigned long classstrlen;
                for (classstrlen = 0; (classstrlen < len && type[classstrlen] != '<') ; classstrlen++) ;
                classstrlen -= classstrlen == len ? 3 : 2;
                if (classstrlen > 0) {
                    char objtypestr[classstrlen+1];
                    memcpy(objtypestr, type+2, classstrlen);
                    objtypestr[classstrlen] = '\0';
                    NSString *className = [NSString stringWithUTF8String:objtypestr];
                    return NSClassFromString(className);
                    //*/
                    /*
                    Class propertyClass = NSClassFromString(className);
                    NSLog(@"[DEBUG] /AUTOMAP/ @property %@ %@ / Class %@ founded", className, propertyKey, propertyClass ?: @"not");
                    return propertyClass;
                    //*/
                }
            } /*else {
                NSLog(@"[DEBUG] /AUTOMAP/ @property id %@", propertyKey);
            } //*/
        } break;
        /*
        case '*':
        case '^':
        case '{': {
            NSLog(@"[ERROR] /AUTOMAP/ @property %s %@ / class '%@' is not KVC-compliant for the key '%@'", type, propertyKey, self.class, propertyKey);
        } break;
        default:
            NSLog(@"[DEBUG] /AUTOMAP/ @property %s %@", type, propertyKey);
            break; //*/
    }
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

- (NSDictionary *)keyedRepresentation {
    NSMutableDictionary *representation = [NSMutableDictionary new];
    for (NSString *key in self.serializableProperties) {
        NSObject *value = [self valueForKey:key];
        value = AKObjectReverseMappingRepresentation(value);
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *origin = (NSDictionary *)value;
            NSMutableDictionary *mutable = [NSMutableDictionary new];            
            [origin enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                mutable[key] = AKObjectReverseMappingRepresentation(obj);
            }];
            value = mutable.copy;
        } else if ([value conformsToProtocol:@protocol(NSFastEnumeration)]) {
            NSMutableArray *mutable = [NSMutableArray new];
            id<NSFastEnumeration> enumeratable = (id<NSFastEnumeration>)value;
            for (id item in enumeratable) {
                [mutable addObject:AKObjectReverseMappingRepresentation(item)];
            }
            value = mutable.copy;
        } else {
            value = value.copy;
        }
        [representation setValue:value forKey:key];
    }
    return representation.copy;
}

@end

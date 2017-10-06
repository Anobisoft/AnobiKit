//
//  AKObject+Mapping.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKObject+Mapping.h"
@import ObjectiveC.runtime;

@implementation AKObject (Mapping)

+ (AKObjectMap *)objectMap {
    return nil;
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation {
    return [self instatiateWithExternalRepresentation:representation objectMap:[self objectMap]];
}

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap {
    AKObjectMap *selfMap = objectMap ?: [self objectMap];
    return [[self alloc] initWithExternalRepresentation:representation objectMap:selfMap];
}

- (instancetype)initWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap {
    if (self = [super init]) {
        [representation enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
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
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    objc_property_t property = class_getProperty(object_getClass(self), [propertyKey UTF8String]);
                    char *type = property_copyAttributeValue(property, "T");
                    unsigned long len = strlen(type);
                    Class propertyClass;
                    
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
                                    propertyClass = NSClassFromString(className);
                                    NSLog(@"[DEBUG] /AUTOMAP/ @property %@ %@ / Class %@ founded", className, propertyKey, propertyClass ?: @"not");

                                }/* else {
                                    unsigned long protocollen = len-classstrlen-2-3;
                                    char objtypestr[protocollen+1];
                                    memcpy(objtypestr, type+2+classstrlen+1, protocollen);
                                    objtypestr[protocollen] = '\0';
                                    NSString *protocolStr = [NSString stringWithUTF8String:objtypestr];
                                    NSArray<NSString *> *protocols = [protocolStr componentsSeparatedByString:@"><"];
                                    NSLog(@"[DEBUG] @property id<%@> %@", protocolStr, obj);
                                    for (NSString *protocolName in protocols) {
                                        Protocol *protocol = NSProtocolFromString(protocolName);
                                        unsigned int ppropcount;
                                        free(protocol_copyPropertyList(protocol, &ppropcount));
                                        if (ppropcount > 0) {
                                            NSLog(@"@protocol <%@> property count %u", protocolName, ppropcount);
                                        }
                                    }
                                } //*/
                            } else {
                                NSLog(@"[DEBUG] /AUTOMAP/ @property id %@", propertyKey);
                            }
                        } break;
                        case '*':
                        case '^':
                        case '{': {
                            NSLog(@"[ERROR] /AUTOMAP/ @property %s %@ / class '%@' is not KVC-compliant for the key '%@'", type, propertyKey, self.class, propertyKey);
                        } break;
                        default:
                            NSLog(@"[DEBUG] /AUTOMAP/ @property %s %@", type, propertyKey);
                            break;
                    }
                    
                    if (propertyClass && [propertyClass isSubclassOfClass:[AKObject class]]) {
                        id newPropertyInstance = [propertyClass instatiateWithExternalRepresentation:obj objectMap:propertyMap.objectMap];
                        [self setValue:newPropertyInstance forKey:propertyKey];
                    } else {
                        @try {
                            [self setValue:obj forKey:propertyKey]; // try to set representation object to property as is (NSDictionary)
                        } @catch (NSException *exception) {
                            NSLog(@"[ERROR] exception: %@", exception);
                        }
                    }
                } else {
                    @try {
                        [self setValue:obj forKey:propertyKey]; // try to set representation object to property as is (id)
                    } @catch (NSException *exception) {
                        NSLog(@"[ERROR] exception: %@", exception);
                    }
                }
            }
        }];
    }
    return self;
}

@end

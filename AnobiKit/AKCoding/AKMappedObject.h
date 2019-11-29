//
//  AKMappedObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-09-29.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKCodableObject.h>
#import <AnobiKit/AKObjectMapping.h>

@interface AKMappedObject : AKCodableObject <AKObjectMapping, AKObjectReverseMapping>

+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation
                                           objectMap:(NSDictionary<NSString *, AKPropertyMap *> *)objectMap;

- (NSDictionary *)keyedRepresentation;

@end

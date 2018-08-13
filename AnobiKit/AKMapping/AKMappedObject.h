//
//  AKMappedObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 29.09.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKCodableObject.h>
#import <AnobiKit/AKObjectMapping.h>

@interface AKMappedObject : AKCodableObject <AKObjectMapping, AKObjectReverseMapping>


@end

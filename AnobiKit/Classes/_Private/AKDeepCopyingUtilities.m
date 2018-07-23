//
//  AKDeepCopyingUtilities.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKDeepCopyingUtilities.h"
#import "AKDeepCopying.h"

id AKMakeDeepCopy(id object) {
    if ([object conformsToProtocol:@protocol(AKDeepCopying)]) {
        return [(id<AKDeepCopying>)object deepcopy];
    }
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        return [(id<NSCopying>)object copyWithZone:nil];
    }
    return object;
}

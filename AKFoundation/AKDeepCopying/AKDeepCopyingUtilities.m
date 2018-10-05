//
//  AKDeepCopyingUtilities.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKDeepCopyingUtilities.h"
#import "AKDeepCopying.h"

__kindof NSObject * AKMakeDeepCopy(__kindof NSObject *object) {
    if ([object conformsToProtocol:@protocol(AKDeepCopying)]) {
        id<AKDeepCopying> deepCopySupported = object;
        return deepCopySupported.deepcopy;
    }
    if ([object conformsToProtocol:@protocol(NSCopying)]) {
        return object.copy;
    }
    return object;
}

//
//  NSSet+AKDeepCopying.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-07-24.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSSet+AKDeepCopying.h"
#import "AKDeepCopyingUtilities.h"

@implementation NSSet (AKDeepCopying)

- (instancetype)deepcopy {
    __kindof NSMutableSet *collection = [self.class new];
    BOOL isMutable = [collection respondsToSelector:@selector(addObject:)];
    if (!isMutable) {
        collection = collection.mutableCopy;
    }
    for (id obj in self) {
        [collection addObject:AKMakeDeepCopy(obj)];
    }
    if (!isMutable) {
        collection = collection.copy;
    }
    return collection;
}

@end

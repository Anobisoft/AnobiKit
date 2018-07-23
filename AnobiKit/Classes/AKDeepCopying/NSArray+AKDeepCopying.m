//
//  NSArray+AKDeepCopying.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSArray+AKDeepCopying.h"
#import "AKDeepCopyingUtilities.h"

@implementation NSArray (AKDeepCopying)

- (instancetype)deepcopy {
    __kindof NSMutableArray *collection = [self.class new];
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

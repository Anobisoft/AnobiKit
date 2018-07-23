//
//  NSDictionary+AKDeepCopying.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSDictionary+AKDeepCopying.h"
#import "AKDeepCopyingUtilities.h"

@implementation NSDictionary (AKDeepCopying)

- (instancetype)deepcopy {
    __kindof NSMutableDictionary *collection = [self.class new];
    BOOL isMutable = [collection respondsToSelector:@selector(setObject:forKey:)];
    if (!isMutable) {
        collection = collection.mutableCopy;
    }
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [collection setObject:AKMakeDeepCopy(obj) forKey:key];
    }];
    if (!isMutable) {
        collection = collection.copy;
    }
    return collection;
}

@end

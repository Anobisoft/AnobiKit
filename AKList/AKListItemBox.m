//
//  AKListItemBox.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKListItemBox.h"

@implementation AKListItemBox {
    id _object;
}

@synthesize next = _next;
@synthesize prev = _prev;

+ (instancetype):(id)object {
    return [[self alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object {
    if (self = [self init]) {
        _object = object;
    }
    return self;
}

- (id)object {
    return _object;
}

@end

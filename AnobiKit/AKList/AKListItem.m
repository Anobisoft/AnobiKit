//
//  AKListItem.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKListItem.h"

@interface AKListItem() {
@protected
    id retained;
}

@end

@implementation AKListItem

@dynamic object;

- (instancetype)initWithObject:(id)object {
    if (self = [self init]) {
        retained = object;
    }
    return self;
}

- (id)object {
    return retained;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [AKListItem :retained];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [AKListMutableItem :retained];
}

@end

@implementation AKListMutableItem

@dynamic object;

- (void)setObject:(id)object {
    retained = object;
}

@end


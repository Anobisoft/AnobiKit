//
//  AKListWeakItem.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKListWeakItem.h"

@interface AKListWeakItem() {
@protected
    __weak id weak;
}

@end

@implementation AKListWeakItem

@dynamic object;

- (instancetype)initWithObject:(id)object {
    if (self = [self init]) {
        weak = object;
    }
    return self;
}

- (id)object {
    return weak;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [AKListWeakItem :weak];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [AKListMutableWeakItem :weak];
}

@end

@implementation AKListMutableWeakItem

@dynamic object;

- (void)setObject:(id)object {
    weak = object;
}

@end

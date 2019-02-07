//
//  AKListAbstractItem.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKListAbstractItem.h"
#import <AnobiKit/AKException.h>

@implementation AKListAbstractItem

@synthesize next = _next;
@synthesize prev = _prev;

@dynamic object; // abstract

+ (instancetype):(id)object {
    if (self == AKListAbstractItem.class) {
        @throw [self abstractClassInstantiationException];
    }
    return [[self alloc] initWithObject:object]; // abstract
}

- (instancetype)initWithObject:(id)object {
    @throw [AbstractMethodException exception];
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self.object respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.object];
        return;
    }
}

@end

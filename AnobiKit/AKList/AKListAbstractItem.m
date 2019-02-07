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
    @throw [AKAbstractMethodException exception];
    return nil;
}

- (BOOL)respondsToSelector:(SEL)selector {
    return [super respondsToSelector:selector] || [self.object respondsToSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.object];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self.object methodSignatureForSelector:aSelector];
    }
    return signature;
}

@end

//
//  NSObject+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.03.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSObject+AnobiKit.h"
#import <objc/runtime.h>

@implementation NSObject (AnobiKit)

+ (BOOL)inheritMethod:(SEL)selector from:(Class)parent {
    Method method = class_getInstanceMethod(parent, selector);
    return class_addMethod(self, selector,
                           method_getImplementation(method),
                           method_getTypeEncoding(method));
}

@end

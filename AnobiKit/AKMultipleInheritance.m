//
//  AKMultipleInheritance.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.03.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKMultipleInheritance.h"
#import <objc/runtime.h>

@implementation NSObject (AKMultipleInheritance)

+ (BOOL)inheritMethod:(SEL)selector from:(Class)parent {
    if ([self isSubclassOfClass:parent]) return true;
    Method method = class_getInstanceMethod(parent, selector);
    return class_addMethod(self, selector,
                           method_getImplementation(method),
                           method_getTypeEncoding(method));
}

@end

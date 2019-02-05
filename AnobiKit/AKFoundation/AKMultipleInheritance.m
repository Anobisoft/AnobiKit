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
    if ([self respondsToSelector:selector]) return true;
    if ([self isSubclassOfClass:parent]) return true;
    Method method = class_getInstanceMethod(parent, selector);
    IMP implementation = method_getImplementation(method);
    const char *typeEncoding = method_getTypeEncoding(method);
    return class_addMethod(self, selector, implementation, typeEncoding);
}

@end

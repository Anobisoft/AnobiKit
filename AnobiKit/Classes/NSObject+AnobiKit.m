//
//  NSObject+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.03.2018.
//

#import "NSObject+AnobiKit.h"
#import <objc/runtime.h>

@implementation NSObject (AnobiKit)

+ (void)inheritMethod:(SEL)sel from:(Class)parent {
    Method method = class_getInstanceMethod(parent, sel);
    class_addMethod(self,
                    sel,
                    method_getImplementation(method),
                    method_getTypeEncoding(method));
}

@end

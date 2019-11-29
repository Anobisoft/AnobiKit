//
//  NSObject+Identification.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-02-21.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSObject+Identification.h"

@implementation NSObject (Identification)

+ (NSString *)classIdentifier {
    NSString *classBundleIdentifier = [NSBundle bundleForClass:self].bundleIdentifier;
    return [classBundleIdentifier stringByAppendingFormat:@".%@", NSStringFromClass(self)];
}

- (NSString *)classIdentifier {
    return self.class.classIdentifier;
}

@end

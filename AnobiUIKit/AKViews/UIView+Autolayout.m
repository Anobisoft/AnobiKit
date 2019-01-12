//
//  UIView+Autolayout.m
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)

+ (instancetype)autolayoutView {
    return [[self alloc] initAutolayout:YES];
}

- (instancetype)initAutolayout:(BOOL)value {
    if (self = [self init]) {
        self.translatesAutoresizingMaskIntoConstraints = !value;
    }
    return self;
}

@end

#endif

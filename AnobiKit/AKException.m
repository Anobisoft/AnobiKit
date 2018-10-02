//
//  AKException.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 02/10/2018.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKException.h"

@implementation AKException

+ (instancetype)exception {
    return [self exceptionWithReason:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason {
    return [self exceptionWithReason:reason userInfo:nil];
}

+ (instancetype)exceptionWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    return [[self alloc] initWithName:NSStringFromClass(self) reason:reason userInfo:userInfo];
}

@end

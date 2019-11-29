//
//  NSError+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-02-21.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "NSError+AnobiKit.h"
#import "NSObject+Identification.h"

@implementation NSError (AnobiKit)

+ (instancetype)errorWithCode:(NSInteger)code description:(NSString *)description {
    return [self errorWithDomain:self.classIdentifier code:code description:description];
}

+ (instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description {
    return [self errorWithDomain:domain code:code userInfo:@{ NSLocalizedDescriptionKey : description }];
}

@end

@implementation NSObject (NSError)

- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description {
    return [NSError errorWithDomain:self.classIdentifier code:code description:description];
}

@end

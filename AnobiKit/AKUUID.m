//
//  AKUUID.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 20.01.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKUUID.h"

@implementation AKUUID



+ (instancetype)UUIDWithData:(NSData *)data {
    uuid_t bytes;
    [data getBytes:bytes length:16];
    return [[self alloc] initWithUUIDBytes:bytes];
}

+ (instancetype)UUIDWithString:(NSString *)string {
    return [[self alloc] initWithUUIDString:string];
}

- (NSData *)data {
    uuid_t bytes;
    [self getUUIDBytes:bytes];
    return [NSData dataWithBytes:bytes length:16];
}

@end

@implementation NSData (AnobiKit)

- (AKUUID *)UUID {
    return [AKUUID UUIDWithData:self];
}

- (NSString *)UUIDString {
    return [self UUID].UUIDString;
}

@end

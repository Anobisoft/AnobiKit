//
//  NSUUID+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 20.01.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUUID (NSData)

+ (instancetype)UUIDWithData:(NSData *)data;
+ (instancetype)UUIDWithString:(NSString *)string;

- (NSData *)data;

@end

@interface NSData (NSUUID)

- (NSUUID *)UUID;
- (NSString *)UUIDString;

@end

//
//  AKCodableObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKDeepCopying.h>

@interface AKCodableObject : NSObject <NSSecureCoding, AKDeepCopying>

+ (NSArray<NSString *> *)readableProperties;
+ (NSArray<NSString *> *)writableProperties;
+ (NSArray<NSString *> *)readonlyProperties;

- (NSArray<NSString *> *)readableProperties;
- (NSArray<NSString *> *)writableProperties;
- (NSArray<NSString *> *)readonlyProperties;

- (BOOL)complementObject:(__kindof AKCodableObject *)obj;
- (BOOL)complementWithObject:(__kindof AKCodableObject *)obj;
- (BOOL)isEmpty;

@end

//
//  AKCodableObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKDeepCopying
- (instancetype)deepcopy;
@end

@interface AKCodableObject : NSObject <NSSecureCoding, AKDeepCopying>
@property (readonly) NSArray<NSString *> *readableProperties;
@property (readonly) NSArray<NSString *> *writableProperties;
@property (readonly) NSArray<NSString *> *readonlyProperties;

@property (readonly, class) NSArray<NSString *> *readableProperties;
@property (readonly, class) NSArray<NSString *> *writableProperties;
@property (readonly, class) NSArray<NSString *> *readonlyProperties;

- (BOOL)mergeToObject:(__kindof AKCodableObject *)obj;
- (BOOL)mergeFromObject:(__kindof AKCodableObject *)obj;
- (BOOL)isEmpty;

@end

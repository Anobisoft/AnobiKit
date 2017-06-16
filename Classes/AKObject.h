//
//  AKObject.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-15
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKObject : NSObject <NSSecureCoding>

+ (NSSet<NSString *> *)propertyExclusions;
@property (readonly) NSArray <NSString *> *serializableProperties;

- (BOOL)mergeToObject:(AKObject *)obj;
- (BOOL)mergeFromObject:(AKObject *)obj;
- (BOOL)isEmpty;

@end

//
//  AKDeepCopying.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKDeepCopying <NSObject>

- (instancetype)deepcopy;

@end

#import <AnobiKit/NSArray+AKDeepCopying.h>
#import <AnobiKit/NSSet+AKDeepCopying.h>
#import <AnobiKit/NSDictionary+AKDeepCopying.h>

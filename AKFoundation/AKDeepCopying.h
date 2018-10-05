//
//  AKDeepCopying.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 23/07/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#ifndef AKDeepCopyingProtocol
#define AKDeepCopyingProtocol

@protocol AKDeepCopying <NSObject>
- (instancetype)deepcopy;
@end

#endif /* AKDeepCopyingProtocol */

#import <AnobiKit/NSArray+AKDeepCopying.h>
#import <AnobiKit/NSSet+AKDeepCopying.h>
#import <AnobiKit/NSDictionary+AKDeepCopying.h>


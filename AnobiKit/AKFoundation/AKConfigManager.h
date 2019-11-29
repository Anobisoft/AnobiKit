//
//  AKConfigManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-03-14.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKFoundation.h>

@interface AKConfigManager : AKSingleton <KeyedSubscript>

@property (class, readonly) AKConfigManager *manager;
@property (class, readonly) NSUInteger cachesize;
@property (readonly) NSUInteger cachesize;

+ (id)configWithName:(NSString *)name;
- (id)configWithName:(NSString *)name;

@end

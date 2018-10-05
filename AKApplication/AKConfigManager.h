//
//  AKConfigManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKDesign.h>

@interface AKConfigManager : AKSingleton <KeyedSubscript>

+ (instancetype)manager;

- (id)configWithName:(NSString *)name;
- (void)setCachesize:(NSUInteger)cachesize;

@end

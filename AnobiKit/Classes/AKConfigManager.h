//
//  AKConfigManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKTypes.h>

@interface AKConfigManager : AKSingleton <KeyedSubscript>

- (id)configWithName:(NSString *)name;
+ (instancetype)manager;

@end

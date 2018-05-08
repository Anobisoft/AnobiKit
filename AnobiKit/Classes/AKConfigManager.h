//
//  AKConfigManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.03.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnobiKit/AKSingleton.h>
#import <AnobiKit/AKInterfaces.h>

@interface AKConfigManager : AKSingleton <KeyedSubscript>

- (id)configWithName:(NSString *)name;
+ (instancetype)manager;

@end

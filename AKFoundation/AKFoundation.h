//
//  AKFoundation.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 03.02.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AKDesign_h
#define AKDesign_h

@protocol KeyedSubscript
- (id)objectForKeyedSubscript:(id)key;
@end

@protocol IndexedSubscript
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
@end

@protocol MutableKeyedSubscript <KeyedSubscript>
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;
@end

@protocol MutableIndexedSubscript <IndexedSubscript>
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
@end

#endif /* AKDesign_h */

#import <AnobiKit/AKDeepCopying.h>
#import <AnobiKit/AKException.h>
#import <AnobiKit/AKMultipleInheritance.h>
#import <AnobiKit/AKSingleton.h>
#import <AnobiKit/AKWeakSingleton.h>
#import <AnobiKit/AKThread.h>
#import <AnobiKit/AKVersion.h>
#import <AnobiKit/AKConfigManager.h>
#import <AnobiKit/AKFileManager.h>
#import <AnobiKit/AKSound.h>
#import <AnobiKit/NSBundle+AnobiKit.h>
#import <AnobiKit/NSDate+AnobiKit.h>
#import <AnobiKit/UIColor+Hex.h>


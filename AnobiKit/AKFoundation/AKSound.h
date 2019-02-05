//
//  AKSound.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKSound : NSObject

@property (readonly) BOOL isPlaing;
@property NSInteger numberOfLoops;

+ (instancetype)soundWithName:(NSString *)name;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)play;
- (void)stop;
- (void)pause;
- (void)loop;
- (void)loop:(NSInteger)l;

@end

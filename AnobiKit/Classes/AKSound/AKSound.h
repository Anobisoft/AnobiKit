//
//  AKSound.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AnobiKit/AKInterfaces.h>

@interface AKSound : NSObject <DisableNSInit>

+ (instancetype)soundWithName:(NSString *)name;
@property (readonly) BOOL isPlaing;
@property NSInteger numberOfLoops;

- (void)play;
- (void)stop;
- (void)pause;
- (void)loop;
- (void)loop:(NSInteger)l;

@end

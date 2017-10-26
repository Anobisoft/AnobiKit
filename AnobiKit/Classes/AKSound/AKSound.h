//
//  AKSound.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AKTypes.h"

@interface AKSound : NSObject <DisableNSInit>

+ (instancetype)soundWithName:(NSString *)name;

- (void)play;
- (void)stop;
- (void)pause;
- (void)loop;

@end

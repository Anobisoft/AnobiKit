//
//  AKSoundPlayer.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKTypes.h"

@interface AKSoundPlayer : NSObject <Abstract>

+ (void)playSound:(NSString *)soundName;
+ (void)stopSound:(NSString *)soundName;
+ (void)pauseSound:(NSString *)soundName;
+ (void)loopSound:(NSString *)soundName;
+ (void)freeSound:(NSString *)soundName;

@end

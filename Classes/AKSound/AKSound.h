//
//  AKSound.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AKSound : NSObject

+ (instancetype)soundWithName:(NSString *)name;

- (void)play;
- (void)stop;
- (void)pause;
- (void)loop;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

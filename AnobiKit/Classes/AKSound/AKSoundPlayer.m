//
//  AKSoundPlayer.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSoundPlayer.h"
#import "AKSound.h"

@implementation AKSoundPlayer

static NSMutableDictionary *sounds;

+ (void)initialize {
    [super initialize];
    sounds = [NSMutableDictionary new];
}

+ (AKSound *)soundWithName:(NSString *)soundName {
    AKSound *sound = sounds[soundName];
    if (!sound) {
        sound = [AKSound soundWithName:soundName];
        if (sound) sounds[soundName] = sound;
    }
    return sound;
}

+ (void)playSound:(NSString *)soundName {
    [[self soundWithName:soundName] play];
}

+ (void)stopSound:(NSString *)soundName {
    AKSound *sound = sounds[soundName];
    if (sound) [sound stop];
}

+ (void)pauseSound:(NSString *)soundName {
    AKSound *sound = sounds[soundName];
    if (sound) [sound pause];
}

+ (void)loopSound:(NSString *)soundName {
    [[self soundWithName:soundName] loop];
}

+ (void)freeSound:(NSString *)soundName {
    [sounds removeObjectForKey:soundName];
}


@end

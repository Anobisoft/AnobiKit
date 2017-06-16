//
//  AKSound.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSound.h"

@implementation AKSound {
    AVAudioPlayer *audioPlayer;
}

+ (instancetype)soundWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], name];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        if (audioPlayer) return self;
    }
    return nil;
}

- (void)play {
    [audioPlayer play];
}

- (void)stop {
    [audioPlayer stop];
}

- (void)pause {
    [audioPlayer pause];
}

- (void)loop {
    audioPlayer.numberOfLoops = -1;
}

@end

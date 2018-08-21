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
        NSString *path = [name isAbsolutePath] ? name : [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            @throw [NSException exceptionWithName:@"FileNotFoundException"
                                           reason:[NSString stringWithFormat:@"file '%@' not found", path]
                                         userInfo:nil];
            return nil;
        }
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        if (error) {
            @throw error;
        }
        if (!audioPlayer) return nil;
    }
    return self;
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

- (void)loop:(NSInteger)l {
    audioPlayer.numberOfLoops = l;
}

- (BOOL)isPlaing {
    return audioPlayer.playing;
}

- (NSInteger)numberOfLoops {
    return audioPlayer.numberOfLoops;
}

- (void)setNumberOfLoops:(NSInteger)numberOfLoops {
    audioPlayer.numberOfLoops = numberOfLoops;
}

@end

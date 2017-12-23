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
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSURL *fileURL = [NSURL fileURLWithPath:path];
            NSError *error;
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
            if (error) NSLog(@"[ERROR] %@", error);
            if (audioPlayer) return self;
        } else {
            @throw [NSException exceptionWithName:@"FileNotFoundException"
                                           reason:[NSString stringWithFormat:@"file '%@' not found", path]
                                         userInfo:nil];
        }
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

- (void)loop:(NSInteger)l {
    audioPlayer.numberOfLoops = l;
}

@end

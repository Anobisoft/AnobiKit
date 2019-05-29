//
//  AKSound.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-04-26.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKSound.h"
#import "AKFileManager.h"
#import "AKException.h"
#import <AVFoundation/AVFoundation.h>

@interface AKSound()

@property (nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation AKSound

+ (instancetype)soundWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        NSString *path = [name isAbsolutePath] ? name : [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            @throw [AKFileNotFoundException exceptionWithPath:path];
            return nil;
        }
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        if (error) {
            @throw error;
        }
        if (!self.audioPlayer) {
            return nil;
        }
    }
    return self;
}

- (void)play {
    [self.audioPlayer play];
}

- (void)stop {
    [self.audioPlayer stop];
}

- (void)pause {
    [self.audioPlayer pause];
}

- (void)loop {
    self.audioPlayer.numberOfLoops = -1;
}

- (void)loop:(NSInteger)l {
    self.audioPlayer.numberOfLoops = l;
}

- (BOOL)isPlaing {
    return self.audioPlayer.playing;
}

- (NSInteger)numberOfLoops {
    return self.audioPlayer.numberOfLoops;
}

- (void)setNumberOfLoops:(NSInteger)numberOfLoops {
    self.audioPlayer.numberOfLoops = numberOfLoops;
}

@end

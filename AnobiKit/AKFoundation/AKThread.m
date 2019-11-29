//
//  NSThread+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-02-05.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKThread.h"

void dispatch_syncmain(void (^block)(void)) {
    [NSThread performBlockOnMainAndWait:block];
}

void dispatch_asyncmain(void (^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), block);
}

@implementation NSThread (AnobiKit)

+ (void)performBlockOnMain:(void (^)(void))block {
    dispatch_asyncmain(block);
}

+ (void)performBlockOnMainAndWait:(void (^)(void))block {
    if ([self isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@end

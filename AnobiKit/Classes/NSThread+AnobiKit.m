//
//  NSThread+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 05.02.2018.
//

#import "NSThread+AnobiKit.h"

void dispatch_syncmain(void (^block)(void)) {
    [NSThread performSyncBlockOnMain:block];
}

void dispatch_asyncmain(void (^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), block);
}

@implementation NSThread (AnobiKit)

+ (void)performSyncBlockOnMain:(void (^)(void))block {
    if ([self isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

+ (void)performAsyncBlockOnMain:(void (^)(void))block {
    dispatch_asyncmain(block);
}

@end

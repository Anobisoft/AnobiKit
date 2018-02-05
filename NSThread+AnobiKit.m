//
//  NSThread+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 05.02.2018.
//

#import "NSThread+AnobiKit.h"

void dispatch_syncmain(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@implementation NSThread (AnobiKit)

@end

//
//  NSThread+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 05.02.2018.
//

#import <Foundation/Foundation.h>

void dispatch_syncmain(void (^block)(void));
void dispatch_asyncmain(void (^block)(void));

@interface NSThread (AnobiKit)

+ (void)performSyncBlockOnMain:(void (^)(void))block;
+ (void)performAsyncBlockOnMain:(void (^)(void))block;

@end

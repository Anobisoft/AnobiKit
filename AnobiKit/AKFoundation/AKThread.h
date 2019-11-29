//
//  NSThread+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-02-05.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

void dispatch_syncmain(void (^block)(void));
void dispatch_asyncmain(void (^block)(void));

@interface NSThread (AnobiKit)

+ (void)performBlockOnMain:(void (^)(void))block;
+ (void)performBlockOnMainAndWait:(void (^)(void))block;

@end

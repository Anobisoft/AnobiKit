//
//  AKWeakList.m
//  AKSyncData
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKWeakList.h"

@interface AKWeakBox : NSObject

@property (nonatomic, weak) id object;
@property (nonatomic, strong) AKWeakBox *next;
@property (nonatomic, strong) AKWeakBox *prev;

- (void)remove;

@end

@implementation AKWeakBox

- (void)remove {
    if (self.prev) {
        self.prev.next = self.next;
    }
    if (self.next) {
        self.next.prev = self.prev;
    }
}

@end

@interface AKWeakList ()

@property (nonatomic) AKWeakBox *root;
@property (nonatomic) AKWeakBox *tail;

@end

@implementation AKWeakList

- (void)enumerateWithBlock:(void (^)(id object))block {
    AKWeakBox *current = self.root;
    while (current != nil) {
        if (current.object) {
            block(current.object);
        } else {
            [current remove];
            _count--;
            if (current == self.root) {
                self.root = current.next;
            }
            if (current == self.tail) {
                self.tail = current.prev;
            }
        }
        current = current.next;
    }
}

- (void)addObject:(id)object {
    if (!object) {
        return;
    }
    AKWeakBox *box = [AKWeakBox new];
    if (!self.root) {
        self.root = box;
    }
    self.tail.next = box;
    box.prev = self.tail;
    self.tail = box;
    _count++;
}

- (void)clear {
    self.root = self.tail = nil;
    _count = 0;
}

- (NSUInteger)strictlyCount {
    [self enumerateWithBlock:^(id  _Nonnull object) {}];
    return self.count;
}

@end

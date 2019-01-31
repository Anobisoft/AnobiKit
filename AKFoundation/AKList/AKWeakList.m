//
//  AKWeakList.m
//  SKManager
//
//  Created by Stanislav Pletnev on 31/01/2019.
//

#import "AKWeakList.h"

@interface WeakBox : NSObject

@property (nonatomic, weak) id object;
@property (nonatomic, strong) WeakBox *next;
@property (nonatomic, strong) WeakBox *prev;

- (void)remove;

@end

@implementation WeakBox

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

@property (nonatomic) WeakBox *root;
@property (nonatomic) WeakBox *tail;


@end

@implementation AKWeakList

- (void)enumerateWithBlock:(void (^)(id object))block {
    WeakBox *current = self.root;
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
    WeakBox *box = [WeakBox new];
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

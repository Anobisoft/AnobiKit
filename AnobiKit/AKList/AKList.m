//
//  AKList.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//


#import <AnobiKit/AKFoundation.h>
#import "AKList.h"
#import "AKListItem.h"
#import "AKListWeakItem.h"

@interface AKList ()

@property (nonatomic, nullable) id<AKListItem> root;
@property (nonatomic, nullable) id<AKListItem> tail;

@end

@implementation AKList {
    Class ItemClass;
}

+ (instancetype)new {
    return [[self alloc] initWithItemClass:AKListItem.class];
}

+ (instancetype)weak {
    return [[self alloc] initWithItemClass:AKListWeakItem.class];
}

+ (instancetype)listWithItemClass:(Class)class {
    if (![class conformsToProtocolThrows:@protocol(AKListItem)]) {
        return nil;
    }
    return [[self alloc] initWithItemClass:class];
}

- (instancetype)initWithItemClass:(Class)class {
    if (self = [super init]) {
        ItemClass = class;
    }
    return self;
}

- (void)addObject:(id)object {
    if (!object) {
        return;
    }
    id<AKListItem> item = [ItemClass :object];
    [self addItem:item];
}

- (void)addItem:(id<AKListItem>)item {
    if (!item) {
        return;
    }
    if (![(id)item conformsToProtocolThrows:@protocol(AKListItem)]) {
        return;
    }
    if (!self.root) {
        self.root = item;
    }
    item.prev = self.tail;
    self.tail.next = item;
    self.tail = item;
    _count++;
}

BOOL IllegalArgumentTest(id arg) {
    BOOL illegal = arg == nil;
    if (illegal) {
        @throw [AKIllegalArgumentException exceptionWithReason:@"argument is nil"];
    }
    return illegal;
}

- (void)enumerateWithBlock:(void (^)(id object))block {
    if (IllegalArgumentTest(block)) {
        return;
    }
    [self enumerateItemsWithBreakableBlock:^BOOL(id<AKListItem>  _Nonnull item) {
        block(item.object);
        return NO;
    }];
}

- (void)enumerateWithBreakableBlock:(BOOL (^)(id object))breakableBlock {
    if (IllegalArgumentTest(breakableBlock)) {
        return;
    }
    [self enumerateItemsWithBreakableBlock:^BOOL(id<AKListItem>  _Nonnull item) {
        return breakableBlock(item.object);
    }];
}

- (void)enumerateItemsWithBlock:(void (^)(id<AKListItem> item))block {
    if (IllegalArgumentTest(block)) {
        return;
    }
    [self enumerateItemsWithBreakableBlock:^BOOL(id<AKListItem>  _Nonnull item) {
        block(item);
        return NO;
    }];
}

- (void)enumerateItemsWithBreakableBlock:(BOOL (^)(id<AKListItem> item))breakableBlock {
    if (IllegalArgumentTest(breakableBlock)) {
        return;
    }
    id<AKListItem> current = self.root;
    while (current != nil) {
        if (current.object) {
            if (breakableBlock(current)) {
                return;
            }
        } else {
            [self removeItem:current];
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



- (void)removeItem:(id<AKListItem>)item {
    if (item.prev) {
        item.prev.next = item.next;
    }
    if (item.next) {
        item.next.prev = item.prev;
    }
}

- (void)clear {
    id<AKListItem> current = self.root;
    id<AKListItem> next;
    while ((next = current.next)) {
        next.prev = nil;
        current.next = nil;
        current = next;
    }
    self.tail = nil;
    self.root = nil;
    _count = 0;
}

- (void)dealloc {
    [self clear];
}

- (void)cleanup {
    [self enumerateWithBlock:^(id  _Nonnull object) {}];
}

- (NSUInteger)strictlyCount {
    [self cleanup];
    return self.count;
}

@end

//
//  AKList.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-10-14
//  Copyright © 2018 Anobisoft. All rights reserved.
//


#import <AnobiKit/AKFoundation.h>
#import "AKList.h"
#import "AKListItemBox.h"
#import "AKListItemWeakBox.h"

@interface AKList ()

@property (nonatomic, nullable) id<AKListItem> root;
@property (nonatomic, nullable) id<AKListItem> tail;

@end

@implementation AKList {
    Class ItemClass;
}

+ (instancetype)new {
    return [[self alloc] initWithItemClass:AKListItemBox.class];
}

+ (instancetype)weak {
    return [[self alloc] initWithItemClass:AKListItemWeakBox.class];
}

+ (instancetype)listWithItemClass:(Class)class {
    if (![class conformsToProtocol:@protocol(AKListItem)]) {
        @throw [self exceptionWithReason:@"class must conforms to <AKListItem> protocol"];
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
    if (![item conformsToProtocol:@protocol(AKListItem)]) {
        @throw [self exceptionWithReason:@"item not conforms to <AKListItem> protocol"];
    }
    if (!self.root) {
        self.root = item;
    }
    self.tail.next = item;
    item.prev = self.tail;
    self.tail = item;
    _count++;
}

- (void)removeItem:(id<AKListItem>)item {
    if (item.prev) {
        item.prev.next = item.next;
    }
    if (item.next) {
        item.next.prev = item.prev;
    }
}

- (void)enumerateWithBlock:(void (^)(id object))block {
    id<AKListItem> current = self.root;
    while (current != nil) {
        if (current.object) {
            block(current.object);
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

- (NSUInteger)strictlyCount {
    [self enumerateWithBlock:^(id  _Nonnull object) {}];
    return self.count;
}

@end

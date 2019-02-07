//
//  AKWeakListTest.m
//  AnobiKit_Tests
//
//  Created by Stanislav Pletnev on 31/01/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

@import XCTest;
@import AnobiKit;

@interface AKWeakListItem : AKListAbstractItem
@end
@implementation AKWeakListItem
@end

@interface AKWeakListTest : XCTestCase

@property AKList *list;
@property NSArray *array;

@end

@implementation AKWeakListTest

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    [super tearDown];
    self.list = nil;
    self.array = nil;
}

- (void)testAutoreleasing {
    @autoreleasepool {
        self.list = [AKList weak];
        self.array = @[[NSUUID UUID],
                       [NSUUID UUID],
                       [NSUUID UUID],
                       [NSUUID UUID],
                       [NSUUID UUID],
                       [NSUUID UUID],
                       [NSUUID UUID]];
        
        
        NSUInteger count = 0;
        for (id object in self.array) {
            count++;
            [self.list addObject:object];
            XCTAssertEqual(self.list.count, count);
        }
        XCTAssertEqual(self.list.count, self.array.count);
        [self.list enumerateWithBlock:^(id  _Nonnull object) {
            XCTAssertTrue([self.array containsObject:object]);
        }];
        // free some
        self.array = [self.array subarrayWithRange:NSMakeRange(2, 3)];
    }
    XCTAssertEqual(self.list.strictlyCount, self.array.count);
}

- (void)testExceptions {
    @try {
        self.list = [AKList listWithItemClass:NSString.class];
    } @catch (NSException *exception) {
        XCTAssertTrue([exception isKindOfClass:AKProtocolException.class]);
    }
    
    self.list = [AKList listWithItemClass:AKWeakListItem.class];    
    @try {
        [self.list addObject:@"test"];
    } @catch (NSException *exception) {
        XCTAssertTrue([exception isKindOfClass:AKProtocolException.class]);
    } @finally {
        self.list = nil;
    }
}

- (void)testForwardingInvocation {
    self.list = [AKList new];
    NSString *object = @"test";
    [self.list addObject:object];
    [self.list enumerateItemsWithBlock:^(id _Nonnull item) {
        NSUInteger length = [item length];
        XCTAssertEqual(length, object.length);
    }];
}


@end


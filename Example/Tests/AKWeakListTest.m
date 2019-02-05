//
//  AKWeakListTest.m
//  AnobiKit_Tests
//
//  Created by Stanislav Pletnev on 31/01/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

@import XCTest;
@import AnobiKit;

@interface AKWeakListTest : XCTestCase

@property AKList *list;
@property NSArray *array;

@end

@implementation AKWeakListTest

- (void)setUp {
    [super setUp];
    self.list = [AKList weak];
    self.array = @[@1, @2, @3, @4, @5, @6, @7];
}

- (void)tearDown {
    [super tearDown];
    self.list = nil;
    self.array = nil;
}

- (void)testAddAndEnumeration {
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
}

@end


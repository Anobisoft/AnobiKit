//
//  AnobiKitTests.m
//  AnobiKitTests
//
//  Created by Anobisoft on 08/02/2017.
//  Copyright (c) 2017 Anobisoft. All rights reserved.
//

@import XCTest;
#import "AKTheme.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    NSUInteger count = [AKTheme allNames].count;
    XCTAssertEqual(count, 3, @"count (%d) equal to 3", count, primitive2);
}

@end


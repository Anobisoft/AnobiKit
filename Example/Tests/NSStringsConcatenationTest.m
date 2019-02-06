//
//  NSStringsConcatenationTest.m
//  AnobiKit_Tests
//
//  Created by Stanislav Pletnev on 08/02/2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

@import XCTest;
@import AnobiKit;

#define OriginStringValue @"origin"

@interface NSStringsConcatenationTest : XCTestCase

@property NSString *origin;

@end

@implementation NSStringsConcatenationTest

- (void)setUp {
    [super setUp];
    
    self.origin = OriginStringValue;
}

- (void)tearDown {
    [super tearDown];
    self.origin = nil;
}

- (void)testConcatMethod {
    NSString *result = [self.origin : @"1" : @"2" : @"3" : @"4ATATAT"];
    XCTAssertEqualObjects(result, @"origin1234ATATAT");
    XCTAssertEqualObjects(self.origin, OriginStringValue);
}

@end


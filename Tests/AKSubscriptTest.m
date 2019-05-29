//
//  AKSubscriptTest.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 18/03/2019.
//  Copyright © 2019 anobisoft. All rights reserved.
//

@import XCTest;
@import AnobiKit;


@interface AKSubscriptTest : XCTestCase

@property NSMapTable *mapTable;
@property NSPointerArray *pointerArray;
@property NSPointerArray *weakPointerArray;
@property NSPointerArray *emptyArray;

@end

@implementation AKSubscriptTest

- (void)setUp {
    [super setUp];
    self.mapTable = [NSMapTable strongToStrongObjectsMapTable];
    self.pointerArray = [NSPointerArray strongObjectsPointerArray];
    self.weakPointerArray = [NSPointerArray weakObjectsPointerArray];
    self.emptyArray = [NSPointerArray strongObjectsPointerArray];
}

- (void)tearDown {
    [super tearDown];
    self.mapTable = nil;
    self.pointerArray = nil;
}

- (void)testKeyedSubscript {
    NSString *key = @"ATATAT";
    NSString *object = @"testKeyedSubscript!";
    [self.mapTable setObject:object forKey:key];
    NSString *value = self.mapTable[key];
    XCTAssertEqualObjects(object, value);
}

- (void)testKeyedSubscriptNilValue {
    NSString *key = @"ATATAT";
    NSString *object = @"testKeyedSubscriptNilValue!";
    [self.mapTable setObject:object forKey:key];
    NSString *value = self.mapTable[@"Other"];
    XCTAssertNil(value);
}

- (void)testMutableKeyedSubscript {
    NSString *key = @"ATATAT";
    NSString *object = @"testMutableKeyedSubscript!";
    self.mapTable[key] = object;
    NSString *value = [self.mapTable objectForKey:key];
    XCTAssertEqualObjects(object, value);
}

- (void)testIndexedSubscript {
    NSString *object = @"testIndexedSubscript!";
    [self.pointerArray addPointer:(__bridge void * _Nullable)(object)];
    NSString *value = self.pointerArray[0];
    XCTAssertEqualObjects(object, value);
}

- (void)testMutableIndexedSubscript {
    NSString *object = @"testMutableIndexedSubscript!";
    self.pointerArray[0] = object;
    NSString *value = [self.pointerArray pointerAtIndex:0];
    XCTAssertEqualObjects(object, value);
}

- (void)testMutableIndexedSubscriptAutoRelease {
    @autoreleasepool {
        NSString *object = @"testMutableIndexedSubscriptAutoRelease!";
        self.weakPointerArray[0] = object;
        NSString *value = self.weakPointerArray[0];
        XCTAssertEqualObjects(object, value);
        XCTAssertEqual(1, self.weakPointerArray.count);
    }
    [self.weakPointerArray compact];
    XCTAssertEqual(0, self.pointerArray.count);
}

- (void)testMutableIndexedSubscriptReplacement {
    NSString *object0 = @"testMutableIndexedSubscript0";
    NSString *object1 = @"testMutableIndexedSubscript1";
    NSString *object2 = @"testMutableIndexedSubscript2";
    NSString *replacement = @"testMutableIndexedSubscriptReplacement";
    self.pointerArray[0] = object0;
    self.pointerArray[1] = object1;
    self.pointerArray[2] = object2;
    NSString *value = self.pointerArray[1];
    XCTAssertEqualObjects(object1, value);
    XCTAssertEqual(3, self.pointerArray.count);
    self.pointerArray[1] = replacement;
    value = self.pointerArray[1];
    XCTAssertEqualObjects(replacement, value);
    XCTAssertEqual(3, self.pointerArray.count);
}

- (void)testMutableIndexedSubscriptWrongIndexThrows {
    NSString *object = @"testWrongIndexMutableIndexedSubscript";
    XCTAssertThrows( self.emptyArray[2] = object );
}

- (void)testMutableIndexedSubscriptNullability {
    NSString *key = @"testMutableIndexedSubscriptNullability";
    __auto_type dict = [NSMutableDictionary new];
    dict[key] = key;
    XCTAssertNotNil(dict[key]);
    dict[key] = nil;
    XCTAssertNil(dict[key]);
    self.mapTable[key] = key;
    XCTAssertNotNil(self.mapTable[key]);
    self.mapTable[key] = nil;
    XCTAssertNil(self.mapTable[key]);
}


@end

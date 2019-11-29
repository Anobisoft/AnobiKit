//
//  AKListTest.m
//  AnobiKit_Tests
//
//  Created by Stanislav Pletnev on 2019-01-31.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

@import XCTest;
@import AnobiKit;

@interface AKListChildItem : AKListAbstractItem
@end
@implementation AKListChildItem
@end

@interface AKListTest : XCTestCase

@property AKList *list;
@property NSArray *array;

@end

@implementation AKListTest

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
    __block int index = 0;
    [self.list enumerateWithBlock:^(id  _Nonnull object) {
        XCTAssertEqual(self.array[index++], object);
    }];
}

- (void)testExceptions {
    XCTAssertThrows( self.list = [AKList listWithItemClass:NSString.class] );
    @try {
        self.list = [AKList listWithItemClass:NSString.class];
    } @catch (NSException *exception) {
        XCTAssertTrue([exception isKindOfClass:AKProtocolException.class]);
    }
    
    self.list = [AKList listWithItemClass:AKListChildItem.class];
    XCTAssertThrows( [self.list addObject:@"test"] );
    @try {
        [self.list addObject:@"test"];
    } @catch (NSException *exception) {
        XCTAssertTrue([exception isKindOfClass:AKAbstractMethodException.class]);
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


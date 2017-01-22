//
//  CEValueColumnTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEValueColumn.h>

@interface CEValueColumnTests : XCTestCase

@end

@implementation CEValueColumnTests

- (void)testColumnInitialValues
{
    CEValueColumn *column = [[CEValueColumn alloc] init];
    XCTAssertEqual(column.count, 0);
}

- (void)testColumnAddSingleValue
{
    CGFloat const addedValue = 1.2345;
    CEValueColumn *column = [[CEValueColumn alloc] init];
    [column addValue:addedValue];
    
    XCTAssertEqual(column.count, 1);
    XCTAssertEqual(column.first, addedValue);
    XCTAssertEqual(column.last, addedValue);
    XCTAssertEqual([column valueAtIndex:0], addedValue);
}

- (void)testAddingMultipleValuesOneByOne
{
    CEValueColumn *column = [[CEValueColumn alloc] init];

    for (NSUInteger i = 0; i < 1005; i++)
    {
        CGFloat value = i + 10;
        [column addValue:value];
    }
    
    XCTAssertEqual(column.count, 1005);
    XCTAssertEqualWithAccuracy(column.first, 10, 0.001);
    XCTAssertEqualWithAccuracy(column.last, 1014, 0.001);
    
    XCTAssertEqualWithAccuracy([column valueAtIndex:70], 80, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:135], 145, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:955], 965, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:999], 1009, 0.001);
}

@end

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

@end

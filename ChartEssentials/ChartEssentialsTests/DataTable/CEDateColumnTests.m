//
//  CEDateColumnTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEDateColumn.h>

@interface CEDateColumnTests : XCTestCase
@end

@implementation CEDateColumnTests

- (void)testColumnInitialValues
{
    CEDateColumn *column = [[CEDateColumn alloc] init];
    XCTAssertEqual(column.count, 0);
    XCTAssertNil(column.first);
    XCTAssertNil(column.last);
}

- (void)testColumnAddSingleValue
{
    NSDate *date = [NSDate date];
    CEDateColumn *column = [[CEDateColumn alloc] init];
    [column addObject:date];
    
    XCTAssertEqual(column.count, 1);
    XCTAssertEqualObjects(column.first, date);
    XCTAssertEqualObjects(column.last, date);
    XCTAssertEqualObjects([column objectAtIndex:0], date);
}

- (void)testAddingMultipleValuesOneByOne
{
    CEDateColumn *column = [[CEDateColumn alloc] init];
    
    NSDate *date = [NSDate date];
    for (NSUInteger i = 0; i < 1005; i++)
    {
        NSDate *dateToAdd = [date dateByAddingTimeInterval:(NSTimeInterval)i];
        [column addObject:dateToAdd];
    }
    
    XCTAssertEqual(column.count, 1005);
    XCTAssertEqualObjects(column.first, date);
    XCTAssertEqualObjects(column.last, [date dateByAddingTimeInterval:1004]);

    XCTAssertEqualObjects([column objectAtIndex:50], [date dateByAddingTimeInterval:50]);
    XCTAssertEqualObjects([column objectAtIndex:125], [date dateByAddingTimeInterval:125]);
    XCTAssertEqualObjects([column objectAtIndex:932], [date dateByAddingTimeInterval:932]);
}

- (void)testAddingMultipleValuesInBatches
{
    NSUInteger const batchSize = 43;
    CEDateColumn *column = [[CEDateColumn alloc] init];
    
    NSMutableArray<NSDate *> *dates = [[NSMutableArray alloc] initWithCapacity:batchSize];
    NSDate *date = [NSDate date];
    
    for(NSUInteger i = 0; i < 100; i++)
    {
        [dates removeAllObjects];
        for (NSUInteger j = 0; j < batchSize; j++)
        {
            [dates addObject:[date dateByAddingTimeInterval:(i + 1) * 45 + j]];
        }
        [column addObjects:dates];
    }
    
    XCTAssertEqual(column.count, batchSize * 100);
    XCTAssertEqualObjects(column.first, [date dateByAddingTimeInterval:45]);
    XCTAssertEqualObjects(column.last, [date dateByAddingTimeInterval:(NSTimeInterval)(4500 + 42)]);
    XCTAssertEqualObjects([column objectAtIndex:42], [date dateByAddingTimeInterval:87]);
    XCTAssertEqualObjects([column objectAtIndex:43], [date dateByAddingTimeInterval:90]);
}

@end

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

- (void)testAddingMultipleValuesInBatches
{
    CEValueColumn *column = [[CEValueColumn alloc] init];
    
    // Arbitrary lenght that column chunk lenght is definitely not divisible by.
    CGFloat valueBatch[37];
    
    for(NSUInteger i = 0; i < 100; i++)
    {
        for (NSUInteger j = 0; j < sizeof(valueBatch) / sizeof(CGFloat); j++)
        {
            valueBatch[j] = (i + 1) * 45 + j;
        }
        [column addValues:valueBatch count:sizeof(valueBatch) / sizeof(CGFloat)];
    }
    
    XCTAssertEqual(column.count, 3700);
    XCTAssertEqualWithAccuracy(column.first, 45, 0.001);
    XCTAssertEqualWithAccuracy(column.last, (CGFloat)(4500 + 36), 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:36], 81, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:37], 90, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:255], 348, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:256], 349, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:511], 660, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:512], 661, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:1023], 1284, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:1024], 1285, 0.001);
}

- (void)testAddingValuesLongerThanChunkLength
{
    CEValueColumn *column = [[CEValueColumn alloc] initWithChunkLength:20];

    CGFloat valueBatch[100];

    for(NSUInteger i = 0; i < sizeof(valueBatch) / sizeof(CGFloat); i++)
    {
        valueBatch[i] = 3 + i * 10;
    }
    
    [column addValues:valueBatch count:sizeof(valueBatch) / sizeof(CGFloat)];
    [column addValues:valueBatch count:45];
    [column addValues:valueBatch count:27];
    
    XCTAssertEqual(column.count, 172);
    XCTAssertEqualWithAccuracy(column.first, 3, 0.001);
    XCTAssertEqualWithAccuracy(column.last, 263, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:19], 193, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:20], 203, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:39], 393, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:40], 403, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:99], 993, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:100], 3, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:101], 13, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:144], 443, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:145], 3, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:159], 143, 0.001);
    XCTAssertEqualWithAccuracy([column valueAtIndex:160], 153, 0.001);
}

@end

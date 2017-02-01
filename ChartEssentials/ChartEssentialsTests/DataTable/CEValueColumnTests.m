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

static NSUInteger _VerifyBufferValues(const CGFloat *buffer, NSUInteger start, NSUInteger total, CGFloat expectedValue)
{
    for (NSUInteger i = start; i < total; i++)
    {
        const CGFloat *verifyValue = buffer + i;
        if (ABS(*verifyValue - expectedValue) > 0.001) return i;
    }
    return NSUIntegerMax;
}

- (void)testReadingValuesByRange
{
    CEValueColumn *column = [[CEValueColumn alloc] initWithChunkLength:40];

    CGFloat valueBatch[100];
    const NSUInteger length = sizeof(valueBatch) / sizeof(CGFloat);
    for (NSUInteger i = 0; i < length; i++)
    {
        valueBatch[i] = i + 5;
    }

    [column addValues:valueBatch count:length];
    [column addValues:valueBatch count:length];
    
    for (NSUInteger i = 0; i < length; i++)
    {
        valueBatch[i] = -1;
    }
    
    // Empty range
    NSUInteger result = [column valuesInRange:NSMakeRange(120, 0) buffer:valueBatch];
    XCTAssertEqual(result, 0);
    XCTAssertEqual(_VerifyBufferValues(valueBatch, 0, length, -1), NSUIntegerMax);
    
    // A range of 1 element
    result = [column valuesInRange:NSMakeRange(65, 1) buffer:valueBatch];
    XCTAssertEqual(result, 1);
    XCTAssertEqualWithAccuracy(valueBatch[0], 70, 0.001);
    XCTAssertEqual(_VerifyBufferValues(valueBatch, 1, length, -1), NSUIntegerMax);
    
    // A range of a few elements crossing a chunk boundary
    result = [column valuesInRange:NSMakeRange(35, 10) buffer:valueBatch];
    XCTAssertEqual(result, 10);
    for (NSUInteger i = 0; i < 10; i++)
    {
        XCTAssertEqualWithAccuracy(valueBatch[i], 40 + i, 0.001);
    }
    XCTAssertEqual(_VerifyBufferValues(valueBatch, 10, length, -1), NSUIntegerMax);
    
    // A range crossing several chunk boundaries
    result = [column valuesInRange:NSMakeRange(30, 75) buffer:valueBatch];
    XCTAssertEqual(result, 75);
    for (NSUInteger i = 0; i < 70; i++)
    {
        XCTAssertEqualWithAccuracy(valueBatch[i], 35 + i, 0.001);
    }
    for (NSUInteger i = 0; i < 5; i++)
    {
        XCTAssertEqualWithAccuracy(valueBatch[70 + i], i + 5, 0.001);
    }
    XCTAssertEqual(_VerifyBufferValues(valueBatch, 75, length, -1), NSUIntegerMax);
    
    // A range in the end
    for (NSUInteger i = 0; i < length; i++)
    {
        valueBatch[i] = -1;
    }
    
    result = [column valuesInRange:NSMakeRange(150, 75) buffer:valueBatch];
    XCTAssertEqual(result, 50);
    for (NSUInteger i = 0; i < 50; i++)
    {
        XCTAssertEqualWithAccuracy(valueBatch[i], 55 + i, 0.001);
    }
    XCTAssertEqual(_VerifyBufferValues(valueBatch, 50, length, -1), NSUIntegerMax);
}

@end

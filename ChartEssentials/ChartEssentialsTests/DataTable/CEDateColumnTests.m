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
#import <Foundation/Foundation.h>
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

- (void)testFindDataRangeFromDateRange
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 1;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeInterval hour = 60 * 60;
    
    NSDate *currentDate = [calendar dateFromComponents:components];
    NSDate *startDate = [currentDate dateByAddingTimeInterval:10 * hour];
    NSDate *finishDate = [currentDate dateByAddingTimeInterval:100 * hour];
    
    CEDateColumn *column = [[CEDateColumn alloc] init];
    [column addObject:currentDate];
    
    for (NSUInteger i = 0; i < 1000; ++i)
    {
        currentDate = [currentDate dateByAddingTimeInterval:hour];
        [column addObject:currentDate];
    }
    
    // Range boundaries fall precisely on the elements
    NSRange resultingRange = [column rangeForStart:startDate finish:finishDate];
    XCTAssertEqual(resultingRange.location, 10);
    XCTAssertEqual(resultingRange.length, 91);
    XCTAssertEqualObjects([column objectAtIndex:resultingRange.location], startDate);
    XCTAssertEqualObjects([column objectAtIndex:resultingRange.location + resultingRange.length - 1], finishDate);
    
    // Range boundaries fall between the elements
    startDate = [startDate dateByAddingTimeInterval:-(hour / 2)];
    finishDate = [finishDate dateByAddingTimeInterval:hour / 3];
    
    resultingRange = [column rangeForStart:startDate finish:finishDate];
    XCTAssertEqual(resultingRange.location, 10);
    XCTAssertEqual(resultingRange.length, 91);
    XCTAssertEqual([startDate compare:[column objectAtIndex:resultingRange.location]], NSOrderedAscending);
    XCTAssertEqual([finishDate compare:[column objectAtIndex:resultingRange.location + resultingRange.length - 1]], NSOrderedDescending);
    
    // Range start and finish fall between two nearest data points, therefore the range is empty
    finishDate = [startDate dateByAddingTimeInterval:hour / 10];
    resultingRange = [column rangeForStart:startDate finish:finishDate];
    XCTAssertEqual(resultingRange.location, 10);
    XCTAssertEqual(resultingRange.length, 0);

    // Range end is far beyond last data point, range covers data until the last value in the column.
    finishDate = [startDate dateByAddingTimeInterval:hour * 2000];
    resultingRange = [column rangeForStart:startDate finish:finishDate];
    XCTAssertEqual(resultingRange.location, 10);
    XCTAssertEqual(resultingRange.length, 991);
    XCTAssertEqualObjects([column objectAtIndex:resultingRange.location + resultingRange.length - 1], column.last);
}

- (void)testCopyDataPointsFromDate
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 1;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeInterval hour = 60 * 60;
    
    NSDate *currentDate = [calendar dateFromComponents:components];
    NSDate *startDate1 = [currentDate dateByAddingTimeInterval:150 * hour];
    NSDate *startDate2 = [currentDate dateByAddingTimeInterval:214 * hour + hour / 2];
    NSDate *startDate3 = [currentDate dateByAddingTimeInterval:995 * hour + hour / 2];
    NSDate *startDate4 = [currentDate dateByAddingTimeInterval:15 * hour + hour / 2];
    NSDate *startDate5 = [currentDate dateByAddingTimeInterval:-(2 * hour)];
    NSDate *startDate6 = [currentDate dateByAddingTimeInterval:2000 * hour];
    NSMutableArray *dataAsArray = [[NSMutableArray alloc] initWithCapacity:1001];
    
    CEDateColumn *column = [[CEDateColumn alloc] init];
    [column addObject:currentDate];
    [dataAsArray addObject:currentDate];
    
    for (NSUInteger i = 0; i < 1000; ++i)
    {
        currentDate = [currentDate dateByAddingTimeInterval:hour];
        [column addObject:currentDate];
        [dataAsArray addObject:currentDate];
    }
    
    NSArray<NSDate *> *expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(150, 35)];
    XCTAssertEqualObjects([column pointsAfter:startDate1 count:35], expectedPoints);

    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(150 - 44, 45)];
    XCTAssertEqualObjects([column pointsBefore:startDate1 count:45], expectedPoints);
    
    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(215, 90)];
    XCTAssertEqualObjects([column pointsAfter:startDate2 count:90], expectedPoints);

    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(214 - 82, 83)];
    XCTAssertEqualObjects([column pointsBefore:startDate2 count:83], expectedPoints);
    
    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(996, 5)];
    XCTAssertEqualObjects([column pointsAfter:startDate3 count:30], expectedPoints);

    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(0, 16)];
    XCTAssertEqualObjects([column pointsBefore:startDate4 count:55], expectedPoints);

    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(0, 30)];
    XCTAssertEqualObjects([column pointsAfter:startDate5 count:30], expectedPoints);
    
    XCTAssertEqualObjects([column pointsBefore:startDate5 count:30], @[]);

    XCTAssertEqualObjects([column pointsAfter:startDate6 count:50], @[]);
    
    expectedPoints = [dataAsArray subarrayWithRange:NSMakeRange(1001 - 45, 45)];
    XCTAssertEqualObjects([column pointsBefore:startDate6 count:45], expectedPoints);
}

@end

//
//  CEDateRangeTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEDateRange.h>

@interface CEDateRangeTests : XCTestCase

@end

@implementation CEDateRangeTests
{
    NSCalendar *_calendar;
}

- (void)setUp
{
    [super setUp];
    _calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    _calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
}


- (void)testFixedDateInterval
{
    NSDate *startDate = [_calendar dateWithEra:1 year:2016 month:2 day:10 hour:3 minute:0 second:0 nanosecond:0];
    NSDate *endDate = [_calendar dateWithEra:1 year:2017 month:2 day:10 hour:7 minute:15 second:0 nanosecond:0];
    CEDateInterval *dailyInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:1];
    
    CEDateRange *fixedRange = [CEDateRange fixedRangeWithStartDate:startDate endDate:endDate dataInterval:dailyInterval];
    
    NSDate *expectedStartDate = [_calendar dateWithEra:1 year:2016 month:2 day:10 hour:0 minute:0 second:0 nanosecond:0];
    NSDate *expectedEndDate = [_calendar dateWithEra:1 year:2017 month:2 day:11 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(fixedRange.startDate, expectedStartDate);
    XCTAssertEqualObjects(fixedRange.endDate, expectedEndDate);
    XCTAssertEqualObjects(fixedRange.dataInterval, dailyInterval);
}

- (void)testIntervalRangeAnchoredToDate
{
    NSDate *endDate = [_calendar dateWithEra:1 year:2017 month:3 day:10 hour:15 minute:33 second:17 nanosecond:0];
    CEDateInterval *dailyInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:1];
    CEDateInterval *yearlyInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitYear quantity:1];
    
    CEDateRange *twoYearDailyRange = [CEDateRange intervalRangeWithRangeInterval:yearlyInterval rangeIntervalQuantity:2 dataInterval:dailyInterval anchoredToEndDate:endDate];

    NSDate *expectedStart = [_calendar dateWithEra:1 year:2015 month:3 day:11 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(twoYearDailyRange.startDate, expectedStart);
    NSDate *expectedEnd = [_calendar dateWithEra:1 year:2017 month:3 day:11 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(twoYearDailyRange.endDate, expectedEnd);
    XCTAssertEqualObjects(twoYearDailyRange.dataInterval, dailyInterval);
}

@end

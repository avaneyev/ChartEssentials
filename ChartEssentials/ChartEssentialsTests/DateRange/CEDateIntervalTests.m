//
//  CEDateIntervalTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEDateInterval.h>

@interface CEDateIntervalTests : XCTestCase
@end

@implementation CEDateIntervalTests
{
    NSCalendar *_calendar;
}

- (void)setUp
{
    [super setUp];
    _calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    _calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
}

- (void)testOneMinuteInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitMinute);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:15 minute:17 second:19 nanosecond:0];

    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 300);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -600);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:15 minute:17 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);

    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:15 minute:18 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testFiveMinuteInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:5];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitMinute);
    XCTAssertEqual(interval.quantity, 5);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 1500);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -3000);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:5 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:10 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}


@end

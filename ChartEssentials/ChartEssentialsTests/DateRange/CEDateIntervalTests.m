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

static const NSTimeInterval oneDay = 24 * 60 * 60;
static const NSTimeInterval oneWeek = 7 * oneDay;

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
    
    NSDate *lastMinuteDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:15 minute:59 second:19 nanosecond:0];
    
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:lastMinuteDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:15 minute:59 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);

    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:lastMinuteDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:5 day:5 hour:16 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
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

- (void)testOneHourInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitHour quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitHour);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 18000);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -36000);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:9 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testThreeHourInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitHour quantity:3];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitHour);
    XCTAssertEqual(interval.quantity, 3);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 54000);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -108000);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:6 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:9 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testOneDayInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitDay);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 5 * oneDay);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -10 * oneDay);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:13 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testThreeDayInterval
{
    // Intervals of multiple days don't make much sense in real life because neither months nor years are divisible
    // into these multi-day quantities, which makes the end result dependent on anchor points.
    // For example,
    // - if intervals were counted from month start, last interval in a month would overlap to next month.
    // - if intervals were counted from year start, last interval in ayear could overlap.
    // - if intervals were counted from reference date (1970-01-01), that would make them arbitrary in any given year.
    //
    // The test is just a reference point to prove that math works.
    
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:3];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitDay);
    XCTAssertEqual(interval.quantity, 3);

    NSDate *dateCloseToMonthStart = [_calendar dateWithEra:1 year:2016 month:8 day:1 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:dateCloseToMonthStart];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:dateCloseToMonthStart], 15 * oneDay);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:dateCloseToMonthStart];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:dateCloseToMonthStart], -30 * oneDay);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:dateCloseToMonthStart];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:8 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:dateCloseToMonthStart];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:8 day:4 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);

    NSDate *dateCloseToMonthEnd = [_calendar dateWithEra:1 year:2016 month:8 day:31 hour:8 minute:9 second:10 nanosecond:0];
    
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:dateCloseToMonthEnd];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:8 day:31 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:dateCloseToMonthEnd];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:9 day:3 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
}

- (void)testOneWeekInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitWeekOfYear quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitWeekOfYear);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    XCTAssertEqual([datePlusFiveIntervals timeIntervalSinceDate:arbitraryDate], 5 * oneWeek);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    XCTAssertEqual([dateMinusTenIntervals timeIntervalSinceDate:arbitraryDate], -10 * oneWeek);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:10 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:17 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testOneMonthInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMonth quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitMonth);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2016 month:12 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(datePlusFiveIntervals, expectedDate);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2015 month:9 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(dateMinusTenIntervals, expectedDate);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:8 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testThreeMonthsInterval
{
    // Three months are one quarter, a very typical value
    
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMonth quantity:3];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitMonth);
    XCTAssertEqual(interval.quantity, 3);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2017 month:10 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(datePlusFiveIntervals, expectedDate);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2014 month:1 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(dateMinusTenIntervals, expectedDate);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:7 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:10 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testOneYearInterval
{
    CEDateInterval *interval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitYear quantity:1];
    
    XCTAssertEqual(interval.unit, NSCalendarUnitYear);
    XCTAssertEqual(interval.quantity, 1);
    
    NSDate *arbitraryDate = [_calendar dateWithEra:1 year:2016 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    
    NSDate *datePlusFiveIntervals = [interval dateByAddingIntervals:5 toDate:arbitraryDate];
    NSDate *expectedDate = [_calendar dateWithEra:1 year:2021 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(datePlusFiveIntervals, expectedDate);
    
    NSDate *dateMinusTenIntervals = [interval dateByAddingIntervals:-10 toDate:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2006 month:7 day:12 hour:8 minute:9 second:10 nanosecond:0];
    XCTAssertEqualObjects(dateMinusTenIntervals, expectedDate);
    
    NSDate *dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2016 month:1 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedDown, expectedDate);
    
    NSDate *dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:arbitraryDate];
    expectedDate = [_calendar dateWithEra:1 year:2017 month:1 day:1 hour:0 minute:0 second:0 nanosecond:0];
    XCTAssertEqualObjects(dateRoundedUp, expectedDate);
    
    NSDate *preciselyRoundedDate = dateRoundedUp;
    dateRoundedDown = [interval dateByRoundingToIntervalUp:NO date:preciselyRoundedDate];
    dateRoundedUp = [interval dateByRoundingToIntervalUp:YES date:preciselyRoundedDate];
    
    XCTAssertEqual(dateRoundedDown, preciselyRoundedDate);
    XCTAssertEqual(dateRoundedUp, preciselyRoundedDate);
}

- (void)testIntervalEquality
{
    CEDateInterval *oneMinuteInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:1];
    CEDateInterval *anotherMinuteInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:1];
    CEDateInterval *tenMinuteInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:10];
    
    XCTAssertEqualObjects(oneMinuteInterval, anotherMinuteInterval);
    XCTAssertNotEqualObjects(oneMinuteInterval, tenMinuteInterval);
    
    CEDateInterval *sixtyMinuteInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitMinute quantity:60];
    CEDateInterval *oneHourInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitHour quantity:1];

    // Sixty minutes are equal to one hour but intervals are not the same.
    XCTAssertNotEqualObjects(sixtyMinuteInterval, oneHourInterval);
    
    CEDateInterval *twoDayInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:2];
    CEDateInterval *anotherTwoDayInterval = [[CEDateInterval alloc] initWithUnit:NSCalendarUnitDay quantity:2];
    XCTAssertEqualObjects(twoDayInterval, anotherTwoDayInterval);
    
    NSDictionary<CEDateInterval *, NSNumber *> *useIntervalAsKey = @{
                                                                     twoDayInterval : @10,
                                                                     oneMinuteInterval: @100
                                                                     };
    XCTAssertEqualObjects(useIntervalAsKey[anotherTwoDayInterval], @10);
    XCTAssertEqualObjects(useIntervalAsKey[anotherMinuteInterval], @100);
}

@end

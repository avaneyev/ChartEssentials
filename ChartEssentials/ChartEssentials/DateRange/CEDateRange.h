//
//  CEDateRange.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateInterval.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Date Range defines a range of data on the time scale.
 Date Range specifies start and end dates of the range as well as data interval
 in which individual data points will be measured.
 
 For example:
 - One year of daily data (from now to the past);
 - 2016-01-01 00:00 to 2016-04-01 00:00 of hourly data.
 
 `CEDateRange` is an abstract base class for a date range and should not be instantiated directly.
 Factory methods should be used to create fixed or interval ranges.
 
 `CEDateRange` class can also be subclassed.
 Subclasses must override `startDate` and `endDate` properties.
 */
@interface CEDateRange : NSObject<NSCopying, NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithInterval:(CEDateInterval *)interval NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly, strong) NSDate *startDate;

@property (nonatomic, readonly, strong) NSDate *endDate;

@property (nonatomic, readonly, strong) CEDateInterval *dataInterval;

/**
 Tests if current range fully covers another date range.
 Returns `YES` if current range contains all data points of another range, and `NO` otherwise.
 This method will always return NO if ranges have different data intervals.
 */
- (BOOL)coversDateRange:(CEDateRange *)dateRange;

/**
 Factory method to define an interval range - a range expressed as a number of intervals.
 For example, "3 years of daily data" is defined with range interval of a year, quantity of 3 and data interval of a day.
 @param rangeInterval an interval defining range, in the example above that's yearly.
 @param quantity number of range intervals in a range. In the above example that's 3.
 @param dataInterval data interval in which data points will be measured. In the above example that's daily.
 @param endDate optional end date to anchor the range to. If nil, current date is used and interval moves dates
 depending on current time.
 */
+ (instancetype)intervalRangeWithRangeInterval:(CEDateInterval *)rangeInterval rangeIntervalQuantity:(NSUInteger)quantity dataInterval:(CEDateInterval *)dataInterval anchoredToEndDate:(nullable NSDate *)endDate;

/**
 Factory method to define a fixed range - a range expressed as data points between certain dates.
 For example, 2016-01-01 00:00 to 2016-04-01 00:00 of hourly data.
 @param startDate the earliest date in a date range. In the above example that's 2016-01-01 00:00.
 @param endDate the latest date in a date range. In the above example that's 2016-04-01 00:00
 @param dataInterval data interval in which data points will be measured. In the above example that's hourly.
 */
+ (instancetype)fixedRangeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate dataInterval:(CEDateInterval *)dataInterval;

@end

NS_ASSUME_NONNULL_END

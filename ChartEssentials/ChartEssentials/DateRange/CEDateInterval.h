//
//  CEDateInterval.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Date interval is a unit in which time is measured in a time series table.
 A few examples:
 - daily (one data point corresponds to one day);
 - weekly (one data point corresponds to one week);
 - 10 minutes (one data point corresponds to 10 minutes).
 Interval is defined by a unit (day, month, minute) and quantity of the named units.
 Intervals are used to define date ranges.
 */
__attribute__((objc_subclassing_restricted))
@interface CEDateInterval : NSObject<NSCopying, NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUnit:(NSCalendarUnit)unit quantity:(NSUInteger)quantity NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSCalendarUnit unit;
@property (nonatomic, readonly) NSUInteger quantity;

/**
 Add a number of date intervals to a date. 
 Interval count can be negative, in that case intervals will be subtracted instead.
 Examples:
 - Add 10 daily intervals - add 10 days to the date.
 - Add 12 intervals of 5 min - add 60 minutes (5 * 12) to the date.
 - Add -1 yearly intervals - subtract 1 year from the date.
 */
- (NSDate *)dateByAddingIntervals:(NSInteger)intervals toDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END

//
//  CEDateColumn.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEDateColumn : NSObject<NSCopying>

/**
 Current element count.
 */
@property (nonatomic, readonly) NSUInteger count;
/**
 First value in the column, or `nil` if column is empty.
 */
@property (nonatomic, readonly, retain, nullable) NSDate *first;
/**
 Last value in the column, or `nil` if column is empty.
 */
@property (nonatomic, readonly, retain, nullable) NSDate *last;

/**
 Adds an individual date object. Dates must be added in ascending order.
 @param object date to add.
 */
- (void)addObject:(NSDate *)object;
/**
 Adds an array of dates. Dates must be added in ascending order.
 @param objects an array of dates.
 */
- (void)addObjects:(NSArray<NSDate *> *)objects;

/**
 Returns an individual date at a specified index.
 @param index index of a value to return.
 @return date at specified index.
 */
- (NSDate *)objectAtIndex:(NSUInteger)index;
/**
 Copies values in the specified range to an array and returns that array.
 @param range a range of data to copy.
 @return array of dates corresponding to the requested range.
 */
- (NSArray<NSDate *> *)objectsInRange:(NSRange)range;

/**
 Determines a range in current data based on starting and final values. Range is inclusive on both sides.
 @param start a starting date of the range.
 @param finish a final date of the range.
 @return a range of data corresponding to these dates.
 */
- (NSRange)rangeForStart:(NSDate *)start finish:(NSDate *)finish;
/**
 Returns a specified nunber of data items before the specified date.
 @param start a date from which the data points are counted.
 @param count requested number of points.
 @return an array of dates before the specified date.
 @discussion This function may return fewer items if there are not enough data points before the specified date.
 */
- (NSArray<NSDate *> *)pointsBefore:(NSDate *)start count:(NSUInteger)count;
/**
 Returns a specified nunber of data items after the specified date.
 @param start a date from which the data points are counted.
 @param count requested number of points.
 @return an array of dates after the specified date.
 @discussion This function may return fewer items if there are not enough data points after the specified date.
 */
- (NSArray<NSDate *> *)pointsAfter:(NSDate *)start count:(NSUInteger) count;

@end

NS_ASSUME_NONNULL_END

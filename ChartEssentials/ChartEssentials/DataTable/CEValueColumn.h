//
//  CEValueColumn.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Defines a class for a column that stores time series values. Values are CGFloat.
 Column is chunked and optimized for adding values to the end and accessing ranges.
 */
@interface CEValueColumn : NSObject<NSCopying>

/**
 Initializes the value column with default chunk length. 
 It is recommended to use default chunk length.
 */
- (instancetype)init;

/**
 Initializes the value column with explicit chunk length.
 */
- (instancetype)initWithChunkLength:(NSUInteger)length;

/**
 Current element count.
 */
@property (nonatomic, readonly) NSUInteger count;

/**
 Adds an individual value.
 @param value value to add.
 */
- (void)addValue:(CGFloat)value;

/**
 Adds an array of values.
 @param values an array of values (must be of at least `count` elements).
 @param count element count.
 */
- (void)addValues:(CGFloat *)values count:(NSUInteger)count;

/**
 Returns an individual value at a specified index.
 @param index index of a value to return.
 @return value at specified index.
 */
- (CGFloat)valueAtIndex:(NSUInteger)index;

/**
 Copies values in the specified range to a buffer.
 @param range a range of data to copy.
 @param buffer an output buffer to copy data to.
 @return actual number of items copied (less than or equal to requested range length).
 */
- (NSUInteger)valuesInRange:(NSRange)range buffer:(CGFloat *)buffer;

/**
 First value in the column
 */
@property (readonly) CGFloat first;

/**
 Last value in the column
 */
@property (readonly) CGFloat last;

/**
 Creates a new column with data from the specified range of the current column.
 */
- (CEValueColumn *)columnFromRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END


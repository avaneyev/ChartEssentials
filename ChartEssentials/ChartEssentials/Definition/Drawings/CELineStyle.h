//
//  CELineStyle.h
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
 Line style class defines line drawing attributes - width, caps and joins, and line dash pattern.
 Line style objects are immutable, to change a line style of a line a new object needs to be set
 to the corresponding definition.
 */
@interface CELineStyle : NSObject<NSCoding, NSCopying>

// initializes a solid line of specified width with default cap and join.
- (instancetype)initWithWidth:(CGFloat)lineWidth;
// initializes a solid line of specified width with specific cap and join.
- (instancetype)initWithWidth:(CGFloat) lineWidth lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin;
// initializes a dashed line of specified width with default cap, join and dash pattern.
- (instancetype)initWithWidth:(CGFloat)lineWidth lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin dashPatternLength:(NSUInteger)patternLength dashPattern:(CGFloat [_Nullable])pattern dashStart:(CGFloat)dashStart NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (readonly, assign) CGFloat lineWidth;

@property (readonly, assign) CGLineCap lineCap;
@property (readonly, assign) CGLineJoin lineJoin;

@property (readonly, getter = dashed) BOOL dashed;

@end

NS_ASSUME_NONNULL_END

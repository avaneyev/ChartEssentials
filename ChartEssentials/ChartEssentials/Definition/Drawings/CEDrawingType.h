//
//  CEDrawingType.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// String name for the simple line drrawing (connecting individual dots).
extern NSString *CEDrawingTypeLineName;
// String name for bar drawing.
extern NSString *CEDrawingTypeBarName;
// String name for area drawing (line with the area under it filled with color or gradient)
extern NSString *CEDrawingTypeAreaName;
// String name for OHLC drawing (OHLC stands for open-high-low-close,
// a vertical line connects low and high with side lines at open and close).
extern NSString *CEDrawingTypeOHLCName;
// String name for candle drawing, another way to render open-high-low-close in one figure.
extern NSString *CEDrawingTypeCandleName;
// String name for step line. Step line does not connect the adjacent points directly,
// instead it makes a horizontal line followed by a vertical line, forming steps.
extern NSString *CEDrawingTypeStepLineName;

@class CEColorScheme;

/**
 Abstract class for all kinds of drawing types (line, bar, area, etc.).
 */
@interface CEDrawingType : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithColorScheme:(CEColorScheme *)colorScheme;

/**
 Drawing type name that can be used to map a drawing type to
 */
@property (nonatomic, readonly) NSString *typeName;

@property (nonatomic, readwrite) CEColorScheme *colorScheme;

@end

NS_ASSUME_NONNULL_END

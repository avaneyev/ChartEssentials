//
//  CEOHLCDrawingType.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDrawingType.h>

NS_ASSUME_NONNULL_BEGIN

/**
 OHLC (open-high-low-close) drawing type describes an OHLC drawing:
 - vertical line connects high and low values;
 - horizontal open line is drawn to the left, horizontal close line - to the right.
 OHLC drawing requires 4 columns, names are assumed to be `open`, `high`, `low` and `close`.
 */
@interface CEOHLCDrawingType : CEDrawingType

@end

NS_ASSUME_NONNULL_END

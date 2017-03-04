//
//  CECandleDrawingType.h
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
 Candle drawing type describes a candle drawing:
 - area from open to close is drawn as a bar;
 - the bar is filled if `open` > `close` and only its outline is rendered otherwise;
 - high extends up and low extends down as lines.
 Candle drawing requires 4 columns, names are assumed to be `open`, `high`, `low` and `close`.
 */
@interface CECandleDrawingType : CEDrawingType

@end

NS_ASSUME_NONNULL_END

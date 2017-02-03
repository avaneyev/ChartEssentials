//
//  CEInstrumentDefinition.h
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
 Instrument definition describes an instrument - anything that has time series data associated with it.
 It may be a stock market ticker, economic indicator, and so on.
 Instrument by itself does not restrict what kind of time series data is associated with it, and same instrument
 may have multiple types, even in the same chart. For example, a stock market ticker can have price data (OHLC series),
 trade volume and a fundamental indicator such as quarterly profit.
 */
@interface CEInstrumentDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

/**
 Initializes an instrument definition with an identifier.
 */
- (instancetype)initWithId:(nonnull NSString *)identifier NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 Instrument identifier - a string that is used by other definition objects to reference the instrument.
 */
@property (nonatomic, readonly) NSString *identifier;

/**
 Instrument caption - a string that is used to display the instrument in a legend.
 */
@property (nonatomic, readwrite, nullable) NSString *caption;

@end

NS_ASSUME_NONNULL_END

//
//  CEVerticalAxisDefinition.h
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
 Vertical axis definition describes the vertical axis of a subchart.
 Vertical axis represents the value portion of time series data.
 Vertical axis may scale the data differently (using linear or logarithmic scale).
 There may be more than one vertical axis in a subchart, 
 and separate axes must be used when data is measured in different units (such as price and volume).
 */
@interface CEVerticalAxisDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithId:(NSString *)axisId NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSString *axisId;
@property (nonatomic, readwrite, nullable) NSString *caption;
@property (nonatomic, readwrite, nullable) NSString *unitName;

@end

NS_ASSUME_NONNULL_END

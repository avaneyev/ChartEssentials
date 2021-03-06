//
//  CEHorizontalAxisDefinition.h
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
 Horizontal axis describes a shared chart axis. Data on all subcharts is scaled based on this axis.
 Horizontal axis is the time axis of the time series data.
 */
@interface CEHorizontalAxisDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithId:(NSString *)axisId NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSString *axisId;

@end

NS_ASSUME_NONNULL_END

//
//  CESubchartLayer.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartContentLayer.h>

NS_ASSUME_NONNULL_BEGIN

@class CEChartView;

@interface CESubchartLayer : CEChartContentLayer

- (instancetype)initWithModel:(__kindof CEChartContentModel *)model scale:(CGFloat)scale NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

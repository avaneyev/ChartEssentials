//
//  CESubchartLayer+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESubchartLayer.h>

NS_ASSUME_NONNULL_BEGIN

@class CESubchartModel;

@interface CESubchartLayer ()

- (instancetype)initWithScale:(CGFloat)scale chartView:(CEChartView *)chartView model:(CESubchartModel *)model NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

//
//  CEChartContentModel+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartContentModel.h>

@class CEChartContentLayer;

@interface CEChartContentModel ()

- (void)_setAssociatedLayer:(nonnull CEChartContentLayer *)layer;

@end

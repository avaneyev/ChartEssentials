//
//  CESubchartModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartContentModel.h>

NS_ASSUME_NONNULL_BEGIN

@class CESubchartDefinition;

@interface CESubchartModel : CEChartContentModel

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) CESubchartDefinition *definition;

@end

NS_ASSUME_NONNULL_END

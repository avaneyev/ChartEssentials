//
//  CESubchartModel+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESubchartModel.h>

NS_ASSUME_NONNULL_BEGIN

@class CEChartModel;

@interface CESubchartModel ()

- (instancetype)initWithDefinition:(CESubchartDefinition *)definition chartModel:(CEChartModel *)chartModel NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly, weak, nullable) CEChartModel *chartModel;

@end

NS_ASSUME_NONNULL_END

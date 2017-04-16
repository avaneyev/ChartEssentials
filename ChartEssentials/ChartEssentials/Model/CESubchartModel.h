//
//  CESubchartModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CEChartModel;
@class CESubchartDefinition;

@interface CESubchartModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDefinition:(CESubchartDefinition *)definition chartModel:(CEChartModel *)chartModel NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) CESubchartDefinition *definition;
@property (nonatomic, readonly, weak, nullable) CEChartModel *chartModel;

@end

NS_ASSUME_NONNULL_END

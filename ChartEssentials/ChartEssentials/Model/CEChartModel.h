//
//  CEChartModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>
#import <ChartEssentials/CEChartView.h>

@class CEChartDefinition;

NS_ASSUME_NONNULL_BEGIN

@interface CEChartModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithChartView:(CEChartView *)view NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly, weak, nullable) CEChartView *view;
@property (nonatomic, readwrite, nullable) CEChartDefinition *definition;
@property (nonatomic, readwrite, weak, nullable) id<CEChartViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

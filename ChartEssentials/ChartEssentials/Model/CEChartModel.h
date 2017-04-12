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

@class CEChartView;

NS_ASSUME_NONNULL_BEGIN

@interface CEChartModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithChartView:(CEChartView *)view NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

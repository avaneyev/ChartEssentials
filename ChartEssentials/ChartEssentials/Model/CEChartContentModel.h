//
//  CEChartContentModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CEChartContentLayer;

@interface CEChartContentModel : NSObject

@property (nonatomic, readonly, weak, nullable) __kindof CEChartContentLayer *layer;

@end

NS_ASSUME_NONNULL_END

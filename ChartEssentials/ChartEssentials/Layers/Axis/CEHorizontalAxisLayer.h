//
//  CEHorizontalAxisLayer.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartContentLayer.h>

NS_ASSUME_NONNULL_BEGIN

@class CEHorizontalAxisModel;

@interface CEHorizontalAxisLayer : CEChartContentLayer

- (instancetype)initWithModel:(CEHorizontalAxisModel *)model scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END

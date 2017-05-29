//
//  CEVerticalAxisLayer.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/ChartEssentials.h>

NS_ASSUME_NONNULL_BEGIN

@class CEVerticalAxisModel;

@interface CEVerticalAxisLayer : CEChartContentLayer

- (instancetype)initWithModel:(CEVerticalAxisModel *)model scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END

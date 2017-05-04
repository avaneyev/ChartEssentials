//
//  CEChartContentLayer.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@class CEChartContentModel;

@interface CEChartContentLayer : NSObject<CALayerDelegate>

- (instancetype)initWithScale:(CGFloat)scale NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

+ (CALayer *)createLayer;

@property (nonatomic, readonly) CALayer *layer;
@property (nonatomic, readonly, weak, nullable) CEChartContentLayer *superlayer;

- (void)addSublayer:(CEChartContentLayer *)layer;
- (void)insertSublayer:(CEChartContentLayer *)layer atIndex:(unsigned int)idx;
- (void)removeFromSuperlayer;

@property (nonatomic, readonly, weak, nullable) CEChartContentModel *model;

@end

NS_ASSUME_NONNULL_END

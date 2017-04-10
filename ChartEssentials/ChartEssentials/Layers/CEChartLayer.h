//
//  CEChartLayer.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEChartLayer : NSObject<CALayerDelegate>

- (instancetype)initWithScale:(CGFloat)scale NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

+ (CALayer *)createLayer;

@property (nonatomic, readonly) CALayer *layer;

@end

NS_ASSUME_NONNULL_END

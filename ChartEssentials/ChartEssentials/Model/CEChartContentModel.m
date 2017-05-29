//
//  CEChartContentModel.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartContentModel.h>
#import "CEChartContentModel+Private.h"
#import <ChartEssentials/CETools.h>

@implementation CEChartContentModel
{
    __weak CEChartContentLayer *_layer;
}

- (void)_setAssociatedLayer:(CEChartContentLayer *)layer
{
    CEAssert(_layer == nil);
    
    _layer = layer;
    [self didSetAssociatedLayer:layer];
}

- (void)didSetAssociatedLayer:(CEChartContentLayer *)layer
{
    // Do nothing, but subclasses may override.
}

@end

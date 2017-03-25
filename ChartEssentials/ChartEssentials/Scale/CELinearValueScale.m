//
//  CELinearValueScale.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CELinearValueScale.h>
#import <ChartEssentials/CEScaleHint.h>

@implementation CELinearValueScale
{
    CGFloat _scaleLow;
    CGFloat _scaleHigh;
    NSArray<CEAxisMarker *> *_markers;
}

- (CGFloat)scaleLow
{
    if (_markers == nil) [self _calculateScale];
    return _scaleLow;
}

- (CGFloat)scaleHigh
{
    if (_markers == nil) [self _calculateScale];
    return _scaleHigh;
}

- (NSArray<CEAxisMarker *> *)markers
{
    if (_markers == nil) [self _calculateScale];
    return _markers;
}

- (void)setRenderHeight:(CGFloat)renderHeight
{
    [super setRenderHeight:renderHeight];
    
    // TODO: maybe don't recalculate for small changes?
}

- (void)_calculateScale
{
    // 1. Determine the required range of data - start with the value range and add values required by hints.
    
    CGFloat low = self.valueRangeLow;
    CGFloat high = self.valueRangeHigh;
    
    for (CEScaleHint *hint in self.hints)
    {
        if (hint.kind == CEScaleHintIncludeValueInRangeKey)
        {
            CGFloat hintValue = hint.value;
            if (hintValue < low) low = hintValue;
            if (hintValue > high) high = hintValue;
        }
    }
}

@end

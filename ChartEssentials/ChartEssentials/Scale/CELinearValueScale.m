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
#import <ChartEssentials/CETools.h>

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

- (CGFloat)scaleValue:(CGFloat)value
{
    if (_markers == nil) [self _calculateScale];
    
    if (isnan(value)) return NAN;
    
    return (value - _scaleLow) * self.renderHeight / (_scaleHigh - _scaleLow);
}

- (void)scaleValues:(const CGFloat *)values outputBuffer:(CGFloat *)output count:(NSUInteger)count
{
    CEAssert(values != NULL);
    CEAssert(output != NULL);
    
    if (_markers == nil) [self _calculateScale];

    CGFloat range = _scaleHigh - _scaleLow;
    CGFloat renderHeight = self.renderHeight;
    for (NSUInteger i=0; i < count; i++)
    {
        CGFloat value = values[i];
        output[i] = isnan(value) ? NAN : (value - _scaleLow) * renderHeight / range;
    }
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

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
#import <ChartEssentials/CEPlatformDefinitions.h>

// Function determines 'magnitude' of a value for the purpose of rounding markers.
// The goal is to pick the magnitude so that the result of dividing the value by it is between 10 and 100.
// Power is the corresponding power of 10 to get the magnitude.
// For example:
// - magnitude of 12345 is 1000, and 12345 is considered on the order of thousands between 12000 and 13000;
// - magnitude of 10 is 1, 10 is considered on the order of singles and will be either between 9 and 11;
// - magnitude of 0.25 is 0.01, the value is in one-hundredths and is between 0.24 and 0.26.
//
// Then magnitude could be used for rounding that appears meaningful, because other values being scaled
// are likely to be of the same magnitude as values usually fluctuate around.
// When the values don't fluctuate around some value, another type of scale (for example, logarithmic)
// may be more appropriate.
static void _CELinearValueScaleGetMagnitude(CGFloat value, NSInteger *outPower, CGFloat *outMagnitude)
{
    CEAssert(value >= 0);
    
    if (value == 0)
    {
        *outPower = 0;
        *outMagnitude = 0;
        return;
    }
    
    if (isnan(value))
    {
        *outPower = NAN;
        *outMagnitude = NAN;
        return;
    }
    
    CGFloat currentValue = value;
    *outPower = 0;
    *outMagnitude = 1;
    
    while (currentValue > 100)
    {
        ++(*outPower);
        *outMagnitude *= 10;
        currentValue /= 10;
    }
    
    if (*outPower == 0)
    {
        while (currentValue < 10)
        {
            --(*outPower);
            *outMagnitude /= 10;
            currentValue *= 10;
        }
    }
}

static NSArray<CEAxisMarker *> *_CELinearValueScaleEqualMarkers(CGFloat low, CGFloat high, NSUInteger count)
{
    CEAssert(count > 0);
    
    CGFloat step = (high - low) / count;
    NSMutableArray<CEAxisMarker *> *markers = [[NSMutableArray alloc] initWithCapacity:count];
    [markers addObject:[[CEAxisMarker alloc] initWithCaption:@"" value:low]];
    
    for (NSUInteger i = 1; i < count; ++i)
    {
        low += step;
        [markers addObject:[[CEAxisMarker alloc] initWithCaption:@"" value:low]];
    }
    
    return markers;
}

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
    _markers = nil;
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
    
    if (high == low)
    {
        // If the only known value is 0, there's nothing to be said about the value magnitude.
        // Just pick an arbitrary range of [0, 1] and present the value on it.
        if (low == 0)
        {
            _scaleLow = 0;
            _scaleHigh = 1;
            _markers = _CELinearValueScaleEqualMarkers(_scaleLow, _scaleHigh, 2);
        }
        else
        {
            // TODO: create 2 markers, one above and one below, based on scale of the values
            // If the value happens to be rounded to scale, include it too
        }
    }
    else
    {
        CGFloat magnitude;
        NSInteger power;
        
        // Low value may be negative and have bigger absolute value that high value,
        // need to get magnitude based on the value that has larger magnitude.
        CGFloat valueForPower = MAX(cefabs(low), cefabs(high));
        _CELinearValueScaleGetMagnitude(valueForPower, &power, &magnitude);
    }
}

@end

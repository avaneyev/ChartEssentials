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

static NSRange _CELinearValueScaleMarkerCountRange(CGFloat renderHeight)
{
    // For now determine the reasonable marker count range statically based on render height.
    // The goal is to make markers so they are not overlapping and not too far.
    // For example, for a chart of 500 pt a good range may be between 6 and 10,
    // scale then picks the exact count based on values.
    // TODO: consider passing the range or finding another way to determine if markers are too close
    
    CEAssert(renderHeight >= 0);
    
    NSUInteger baselineIntervals = renderHeight / 40;
    if (baselineIntervals <= 1)
    {
        return NSMakeRange(2, 1);
    }
    
    if (baselineIntervals > 8)
    {
        return NSMakeRange(6, 4);
    }
    
    
    NSUInteger min = baselineIntervals * 3 / 4;
    NSUInteger max = min * 2 - baselineIntervals / 4;
    return NSMakeRange(min, MAX(max - min, 1));
}

static NSArray<CEAxisMarker *> *_CELinearValueScaleEqualMarkers(CGFloat low, CGFloat step, NSUInteger count, NSNumberFormatter *valueFormatter)
{
    CEAssert(count > 0);
    
    NSMutableArray<CEAxisMarker *> *markers = [[NSMutableArray alloc] initWithCapacity:count];
    [markers addObject:[[CEAxisMarker alloc] initWithCaption:[valueFormatter stringFromNumber:@(low)] value:low]];
    
    for (NSUInteger i = 1; i < count; ++i)
    {
        low += step;
        [markers addObject:[[CEAxisMarker alloc] initWithCaption:[valueFormatter stringFromNumber:@(low)] value:low]];
    }
    
    return markers;
}

@implementation CELinearValueScale
{
    CGFloat _scaleLow;
    CGFloat _scaleHigh;
    NSArray<CEAxisMarker *> *_markers;
    
    NSNumberFormatter *_markerFormatter;
}

- (instancetype)initWithValueRangeLow:(CGFloat)low high:(CGFloat)high renderHeight:(CGFloat)renderHeight hints:(NSArray<CEScaleHint *> *)hints
{
    if (self = [super initWithValueRangeLow:low high:high renderHeight:renderHeight hints:hints])
    {
        // TODO: create the formatter based on order, accept a factory in an initializer?
        _markerFormatter = [[NSNumberFormatter alloc] init];
        _markerFormatter.positiveFormat = @"#0.###";
    }
    return self;
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
    
    CGFloat magnitude;
    NSInteger power;

    if (high == low)
    {
        // If the only known value is 0, there's nothing to be said about the value magnitude.
        // Just pick an arbitrary range of [0, 1] and present the value on it.
        if (low == 0)
        {
            _scaleLow = 0;
            _scaleHigh = 1;
            _markers = _CELinearValueScaleEqualMarkers(_scaleLow, 1, 2, _markerFormatter);
        }
        else
        {
            // Create 2 markers, one above and one below, based on scale of the values
            // If the value happens to be rounded to scale, include it too
            
            _CELinearValueScaleGetMagnitude(low, &power, &magnitude);
            _scaleLow = cetrunc(low / magnitude) * magnitude;
            _scaleHigh = _scaleLow + magnitude;
            if (_scaleLow == low)
            {
                _scaleLow -= magnitude;
                _markers = _CELinearValueScaleEqualMarkers(_scaleLow, magnitude, 3, _markerFormatter);
            }
            else
            {
                _markers = _CELinearValueScaleEqualMarkers(_scaleLow, magnitude, 2, _markerFormatter);
            }
        }
    }
    else
    {
        // Low value may be negative and have bigger absolute value that high value,
        // need to get magnitude based on the value that has larger magnitude.
        CGFloat valueForPower = MAX(cefabs(low), cefabs(high));
        NSRange proposedMarkerCountRange = _CELinearValueScaleMarkerCountRange(self.renderHeight);
        CEAssert(proposedMarkerCountRange.location >= 2);

        _CELinearValueScaleGetMagnitude(valueForPower, &power, &magnitude);
        
        // Corner case: value magnitude is high but the variance of data is very low
        // (maybe very few values, or just stable value).
        // For example, a column with values of [1,000,002; 1,000,007; 999,989]
        // will have value magnitude of 100,000 but on that magnitude there is no difference
        // between values and putting even 2 markers of that magnitude will loose any precision.
        // Therefore, need to divide the magnitude until there is visible distance between values.
        
        CGFloat minimumMarkedRange = (proposedMarkerCountRange.location - 1) * magnitude;
        NSUInteger maxMarkerCount = proposedMarkerCountRange.location + proposedMarkerCountRange.length;
        CGFloat initialRange = (high - low);
        if (minimumMarkedRange >= initialRange)
        {
            do
            {
                CGFloat dividedRange = minimumMarkedRange / 2;
                if (dividedRange >= initialRange)
                {
                    magnitude /= 10;
                    minimumMarkedRange /= 10;
                }
                else
                {
                    magnitude /= 2;
                    minimumMarkedRange = dividedRange;
                    break;
                }
            } while (minimumMarkedRange >= initialRange);
        }
        
        // Among the range of suggested marker counts pick the count where actual data range occupies
        // the largest percentage of the available chart area.
        // For example, if data lies in the range of [107, 121] and proposed marker count is between 3 and 5,
        // the options might be:
        // - [105, 115, 125], and data occupies 80% of the area;
        // - [100, 110, 120, 130] and data occupies 53,3%;
        // - [100, 110, 120, 130, 140].
        // The first option is the best because it uses the most of chart's available area for drawing.
        CGFloat magnitudeLow = cetrunc(low / magnitude);
        CGFloat magnitudeHigh = ceceil(high / magnitude);
        CGFloat magnitudeDataRange = magnitudeHigh - magnitudeLow;
        CGFloat mostOccupied = 0;
        CGFloat optimalStep = 0;
        NSUInteger optimalIntervals = 0;
        
        for (NSUInteger intervals = proposedMarkerCountRange.location - 1; intervals < maxMarkerCount - 1; ++intervals)
        {
            CGFloat step = ceceil(magnitudeDataRange / intervals);
            CGFloat span = step * intervals;
            CGFloat occupationPercentage = magnitudeDataRange / span;
            if (occupationPercentage > mostOccupied)
            {
                mostOccupied = occupationPercentage;
                optimalStep = step;
                optimalIntervals = intervals;
            }
        }
        
        CEAssert(optimalStep > 0);
        
        _scaleLow = magnitudeLow * magnitude;
        CGFloat trueStep = optimalStep * magnitude;
        _scaleHigh = _scaleLow + optimalIntervals * trueStep;
        _markers = _CELinearValueScaleEqualMarkers(_scaleLow, trueStep, optimalIntervals + 1, _markerFormatter);
    }
    
    CEAssert(_scaleLow <= low && _scaleHigh >= high);
}

@end

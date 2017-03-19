//
//  CEValueScale.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEValueScale.h>
#import <ChartEssentials/CETools.h>

@implementation CEAxisMarker
{
    NSString *_caption;
    CGFloat _value;
}

- (instancetype)initWithCaption:(NSString *)caption value:(CGFloat)value
{
    if (self = [super init])
    {
        _caption = [caption copy];
        _value = value;
    }
    return self;
}

@synthesize caption = _caption;
@synthesize value = _value;

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end

@implementation CEValueScale
{
    CGFloat _valueRangeLow;
    CGFloat _valueRangeHigh;
    CGFloat _renderHeight;
    NSArray<CEScaleHint *> *_hints;
}

- (instancetype)initWithValueRangeLow:(CGFloat)low high:(CGFloat)high renderHeight:(CGFloat)renderHeight hints:(NSArray<CEScaleHint *> *)hints
{
    if (self = [super init])
    {
        _valueRangeLow = low;
        _valueRangeHigh = high;
        _renderHeight = renderHeight;
        _hints = [hints copy];
    }
    return self;
}

#pragma mark - Properties

@synthesize valueRangeLow = _valueRangeLow;
@synthesize valueRangeHigh = _valueRangeHigh;
@synthesize renderHeight = _renderHeight;
@synthesize hints = _hints;

- (CGFloat)scaleLow
{
    THROW_ABSTRACT(nil);
}

- (CGFloat)scaleHigh
{
    THROW_ABSTRACT(nil);
}

- (NSArray<CEAxisMarker *> *)markers
{
    THROW_ABSTRACT(nil);
}

@end

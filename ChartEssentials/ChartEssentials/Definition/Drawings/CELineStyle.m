//
//  CELineStyle.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CELineStyle.h>
#import <ChartEssentials/CETools.h>

@implementation CELineStyle
{
    CGFloat _lineWidth;
    CGLineCap _lineCap;
    CGLineJoin _lineJoin;
    
    NSUInteger _dashPatternLength;
    CGFloat *_dashLengths;
    CGFloat _dashStart;
}

- (instancetype)initWithWidth:(CGFloat)lineWidth lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin dashPatternLength:(NSUInteger)patternLength dashPattern:(CGFloat [])pattern dashStart:(CGFloat)dashStart
{
    CEAlwaysAssert((patternLength > 0 && pattern != nil) || (patternLength == 0 && pattern == nil));
    CEAlwaysAssert(lineWidth >= 0);
    
    if (self = [super init])
    {
        _lineWidth = lineWidth;
        _lineCap = lineCap;
        _lineJoin = lineJoin;
        
        if (patternLength > 0)
        {
            _dashPatternLength = patternLength;
            size_t dashSize = sizeof(CGFloat) * patternLength;
            _dashLengths = malloc(dashSize);
            memcpy(_dashLengths, pattern, dashSize);
            _dashStart = dashStart;
        }
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)lineWidth lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin
{
    return [self initWithWidth:lineWidth lineCap:lineCap lineJoin:lineJoin dashPatternLength:0 dashPattern:NULL dashStart:0];
}

- (instancetype)initWithWidth:(CGFloat)lineWidth
{
    return [self initWithWidth:lineWidth lineCap:kCGLineCapButt lineJoin:kCGLineJoinMiter dashPatternLength:0 dashPattern:NULL dashStart:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        // TODO: decode object contents
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // TODO: encode object contents
}

- (void)dealloc
{
    if (_dashLengths)
    {
        free(_dashLengths);
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Properties

@synthesize lineWidth = _lineWidth;
@synthesize lineCap = _lineCap;
@synthesize lineJoin = _lineJoin;

- (BOOL)dashed
{
    return _dashLengths != NULL;
}

@end

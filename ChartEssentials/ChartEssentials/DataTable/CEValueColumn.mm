//
//  CEValueColumn.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEValueColumn.h>
#import <ChartEssentials/CETools.h>
#import <vector>

@implementation CEValueColumn
{
    NSUInteger _totalCount;
    NSUInteger _chunkLength;
    std::vector<CGFloat *> _chunks;
}

- (instancetype)init
{
    const size_t defaultChunkLength = 4096 / sizeof(CGFloat);
    return [self initWithChunkLength:defaultChunkLength];
}

- (instancetype)initWithChunkLength:(NSUInteger)length
{
    if (self = [super init])
    {
        _totalCount = 0;
        _chunkLength = length;
    }
    return self;
}

- (instancetype)initWithColumn:(CEValueColumn *)column valueRange:(NSRange)range
{
    THROW_NOT_IMPLEMENTED(nil);
}

- (void)dealloc
{
    for (auto it = _chunks.begin(); it != _chunks.end(); ++it)
    {
        delete (*it);
    }
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] initWithColumn:self valueRange:NSMakeRange(0, _totalCount)];
}

#pragma mark - Public interface

- (NSUInteger)count
{
    return _totalCount;
}

- (CGFloat)first
{
    if (_totalCount == 0)
    {
        @throw [NSException exceptionWithName:NSRangeException reason: @"Column is empty" userInfo:nil];
    }

    auto it = _chunks.begin();
    return (*it)[0];
}

- (CGFloat)last
{
    if (_totalCount == 0)
    {
        @throw [NSException exceptionWithName:NSRangeException reason: @"Column is empty" userInfo:nil];
    }

    auto it = --(_chunks.end());
    NSUInteger lastIndex = _totalCount % _chunkLength;
    return (*it)[lastIndex - 1];
}

- (void)addValue:(CGFloat)value
{
    
}

- (void)addValues:(CGFloat *)values count:(NSUInteger)count
{
    
}

- (CGFloat)valueAtIndex:(NSUInteger)index
{
    return 0;
}

- (NSUInteger)valuesInRange:(NSRange)range buffer:(CGFloat *)buffer
{
    return 0;
}

- (CEValueColumn *)columnFromRange:(NSRange)range
{
    // TODO: is it possible to reuse the same data chunks rather than copying data?
    return [[CEValueColumn alloc] initWithColumn:self valueRange:range];
}

@end

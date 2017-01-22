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
    CGFloat *_lastChunk;
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
        _lastChunk = NULL;
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
        @throw [NSException exceptionWithName:NSRangeException reason:@"Column is empty" userInfo:nil];
    }

    auto it = _chunks.begin();
    return (*it)[0];
}

- (CGFloat)last
{
    if (_totalCount == 0)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"Column is empty" userInfo:nil];
    }

    NSUInteger lastIndex = _totalCount % _chunkLength;
    return _lastChunk[lastIndex - 1];
}

- (void)addValue:(CGFloat)value
{
    NSUInteger lastIndex = _totalCount % _chunkLength;
    if (lastIndex > 0)
    {
        _lastChunk[lastIndex] = value;
    }
    else
    {
        _lastChunk = (CGFloat *)malloc(sizeof(CGFloat) * _chunkLength);
        _lastChunk[0] = value;
        _chunks.push_back(_lastChunk);
    }
    _totalCount++;
}

- (void)addValues:(CGFloat *)values count:(NSUInteger)count
{
    NSUInteger lastIndex = _totalCount % _chunkLength;
    CGFloat *memStart;
    
    if (_chunkLength - lastIndex >= count)
    {
        memStart = _lastChunk + lastIndex;
        memcpy(memStart, values, sizeof(CGFloat) * count);
    }
    else
    {
        const size_t chunkSize = sizeof(CGFloat) * _chunkLength;
        if (lastIndex + 1 < _chunkLength)
        {
            // copy until the end of the current chunk
            size_t count = _chunkLength - lastIndex;
            memStart = _lastChunk + lastIndex;
            memcpy(memStart, values, sizeof(CGFloat) * count);
            
        }
        
        while (count >= _chunkLength)
        {
            _lastChunk = (CGFloat *)malloc(chunkSize);
            memcpy(_lastChunk, values, chunkSize);
            count -= _chunkLength;
            values += _chunkLength;
        }
        
        if (count > 0)
        {
            // copy remainig items
        }
    }
}

- (CGFloat)valueAtIndex:(NSUInteger)index
{
    if (index >= _totalCount)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"Index %ld is beyond column length %ld", (long)index, (long)_totalCount] userInfo:nil];
    }
    
    NSUInteger chunkNumber = index / _chunkLength;
    NSUInteger indexInChunk = index % _chunkLength;
    
    return _chunks[chunkNumber][indexInChunk];
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

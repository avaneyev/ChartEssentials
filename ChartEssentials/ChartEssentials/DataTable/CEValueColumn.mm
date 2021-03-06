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
#import <ChartEssentials/CEDateIndexedTable.h>
#import <ChartEssentials/CETools.h>
#import "CEValueColumn+Private.h"
#import "CEValueColumn+Range.h"
#import <vector>
#include <functional>

void _CEValueColumnIterateChunks(
                                 NSRange range,
                                 const std::vector<CGFloat *> &chunks,
                                 const NSUInteger totalCount,
                                 const NSUInteger chunkLength,
                                 std::function< void(CGFloat *, NSUInteger) > &processChunk
                                 )
{
    NSUInteger firstChunk = range.location / chunkLength;
    NSUInteger firstPosition = range.location % chunkLength;
    NSUInteger remainingInChunk = chunkLength - firstPosition;
    NSUInteger remainingInColumn = totalCount - range.location;
    auto iterator = chunks.cbegin() + firstChunk;
    
    if (remainingInChunk >= range.length && remainingInColumn >= range.length)
    {
        processChunk(*iterator + firstPosition, range.length);
    }
    else
    {
        NSUInteger iteratedLength = MIN(remainingInChunk, remainingInColumn);
        processChunk(*iterator + firstPosition, iteratedLength);
        remainingInColumn -= iteratedLength;
        
        while (remainingInColumn > 0 && iteratedLength < range.length)
        {
            ++iterator;
            remainingInChunk = MIN(range.length - iteratedLength, MIN(remainingInColumn, chunkLength));
            processChunk(*iterator, remainingInChunk);
            iteratedLength += remainingInChunk;
            remainingInColumn -= remainingInChunk;
        }
    }
}

@implementation CEValueColumn
{
    NSUInteger _totalCount;
    NSUInteger _chunkLength;
    std::vector<CGFloat *> _chunks;
    CGFloat *_lastChunk;
    
    __weak CEDateIndexedTable *_table;
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
    // TODO: is it possible to reuse the same data chunks rather than copying data?
    // A possible efficient solution is to have variable first chunk size
    // while all other chunks will still have same size constant per column.
    // That way it is still possible to find a chunk based on index without iterating through them.
    // Chunks will have to be reference counted.
    
    THROW_NOT_IMPLEMENTED(nil);
}

- (void)dealloc
{
    for (auto it = _chunks.begin(); it != _chunks.end(); ++it)
    {
        delete (*it);
    }
}

@synthesize _table = _table;

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
    
    _totalCount += count;
    
    // If there is space is the current chunk, fill it up first
    if (lastIndex != 0)
    {
        if (_chunkLength - lastIndex >= count)
        {
            memStart = _lastChunk + lastIndex;
            memcpy(memStart, values, sizeof(CGFloat) * count);
            
            return;
        }
        else
        {
            NSUInteger copyCount = _chunkLength - lastIndex;
            memStart = _lastChunk + lastIndex;
            memcpy(memStart, values, sizeof(CGFloat) * copyCount);
            values += copyCount;
            count -= copyCount;
        }
    }
    
    const size_t chunkSize = sizeof(CGFloat) * _chunkLength;
    
    // copy whole chunks
    while (count >= _chunkLength)
    {
        _lastChunk = (CGFloat *)malloc(chunkSize);
        _chunks.push_back(_lastChunk);
        memcpy(_lastChunk, values, chunkSize);
        count -= _chunkLength;
        values += _chunkLength;
    }
        
    // copy remainig items
    if (count > 0)
    {
        _lastChunk = (CGFloat *)malloc(chunkSize);
        _chunks.push_back(_lastChunk);
        memcpy(_lastChunk, values, sizeof(CGFloat) * count);
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
    if (range.location >= _totalCount)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"Range %@ is beyond column length %ld", NSStringFromRange(range), (long)_totalCount] userInfo:nil];
    }
    
    if (buffer == NULL) THROW_INVALID_PARAM(buffer, nil);
    
    if (range.length == 0) return 0;
    
    NSUInteger copiedLength = 0;
    std::function< void(CGFloat *, NSUInteger) > copyDataLambda = [&copiedLength, buffer](CGFloat *chunk, NSUInteger length) {
        memcpy(buffer + copiedLength, chunk, sizeof(CGFloat) * length);
        copiedLength += length;
    };
    _CEValueColumnIterateChunks(range, _chunks, _totalCount, _chunkLength, copyDataLambda);
    
    return copiedLength;
}

- (CEValueColumn *)columnFromRange:(NSRange)range
{
    return [[CEValueColumn alloc] initWithColumn:self valueRange:range];
}

@end

@implementation CEValueColumn (ValueRange)

- (void)addValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange
{
    CEAssert(valueRange != NULL);
    CEAssert(range.location + range.length <= _totalCount);
    
    if (range.length == 0) return;
    
    std::function< void(CGFloat *, NSUInteger) > addToScaleLambda = [valueRange](CGFloat *chunk, NSUInteger length) {
        valueRange->addValues(chunk, length);
    };
    _CEValueColumnIterateChunks(range, _chunks, _totalCount, _chunkLength, addToScaleLambda);
}

- (void)addHighValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange
{
    CEAssert(valueRange != NULL);
    CEAssert(range.location + range.length <= _totalCount);
    
    if (range.length == 0) return;
    
    std::function< void(CGFloat *, NSUInteger) > addToScaleLambda = [valueRange](CGFloat *chunk, NSUInteger length) {
        valueRange->addHighValues(chunk, length);
    };
    _CEValueColumnIterateChunks(range, _chunks, _totalCount, _chunkLength, addToScaleLambda);
}

- (void)addLowValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange
{
    CEAssert(valueRange != NULL);
    CEAssert(range.location + range.length <= _totalCount);
    
    if (range.length == 0) return;
    
    std::function< void(CGFloat *, NSUInteger) > addToScaleLambda = [valueRange](CGFloat *chunk, NSUInteger length) {
        valueRange->addLowValues(chunk, length);
    };
    _CEValueColumnIterateChunks(range, _chunks, _totalCount, _chunkLength, addToScaleLambda);
}

@end

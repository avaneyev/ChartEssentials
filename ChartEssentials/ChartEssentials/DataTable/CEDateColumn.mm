//
//  CEDateColumn.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateColumn.h>
#import <ChartEssentials/CEDateIndexedTable.h>
#import <ChartEssentials/CETools.h>
#import "CEDateColumn+Private.h"
#import <vector>

@implementation CEDateColumn
{
    std::vector<NSDate *> _data;
    __weak CEDateIndexedTable *_table;
}

@synthesize _table = _table;

- (id)copyWithZone:(NSZone *)zone
{
    CEDateColumn *copy = [[[self class] allocWithZone:zone] init];
    copy->_data = std::vector<NSDate *>(_data);
    return copy;
}

- (NSUInteger)count
{
    return _data.size();
}

- (NSDate *)first
{
    auto it = _data.cbegin();
    if (it == _data.cend()) return nil;
    return *it;
}

- (NSDate *)last
{
    auto it = _data.crbegin();
    if (it == _data.crend()) return nil;
    return *it;
}

- (void)addObject:(NSDate *)object
{
    CEAssert(_data.size() == 0 || [*_data.crbegin() compare:object] == NSOrderedAscending);
    _data.push_back(object);
}

- (void)addObjects:(NSArray<NSDate *> *)objects
{
    for (NSDate *date in objects)
    {
        CEAssert(_data.size() == 0 || [*_data.crbegin() compare:date] == NSOrderedAscending);
        _data.push_back(date);
    }
}

- (NSDate *)objectAtIndex:(NSUInteger)index
{
    return _data[index];
}

- (NSArray<NSDate *> *)objectsInRange:(NSRange)range
{
    if (range.location >= _data.size()) THROW_INVALID_PARAM(range, nil);
    if (range.length == 0) return @[];
    
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:range.length];
    auto it = _data.cbegin() + range.location;
    NSUInteger copied = 0;
    for (it = _data.cbegin() + range.location; copied < range.length && it != _data.cend(); ++it, ++copied)
    {
        [results addObject:*it];
    }
    return results;
}

- (NSRange)rangeForStart:(NSDate *)start finish:(NSDate *)finish
{
    if (start == nil) THROW_INVALID_PARAM(start, nil);
    if (finish == nil) THROW_INVALID_PARAM(start, nil);
    if ([start compare:finish] != NSOrderedAscending) return NSMakeRange(NSNotFound, 0);
    
    auto startIt = std::lower_bound(_data.cbegin(), _data.cend(), start, [](NSDate *lhs, NSDate *rhs) -> bool { return [lhs compare:rhs] == NSOrderedAscending; });
    auto finishIt = --std::upper_bound(startIt, _data.cend(), finish, [](NSDate *lhs, NSDate *rhs) -> bool { return [lhs compare:rhs] == NSOrderedAscending; });

    return NSMakeRange(startIt - _data.cbegin(), finishIt - startIt + 1);
}

- (NSArray<NSDate *> *)pointsAfter:(NSDate *)start count:(NSUInteger)count
{
    if (start == nil) THROW_INVALID_PARAM(start, nil);
    if (count == 0 || [start compare:*_data.crbegin()] == NSOrderedDescending) return @[];
    
    auto end = _data.cend();
    auto startIt = std::lower_bound(_data.cbegin(), end, start, [](NSDate *lhs, NSDate *rhs) -> bool { return [lhs compare:rhs] == NSOrderedAscending; });
    NSUInteger availableCount = end - startIt;
    auto endIt = availableCount < count ? end : startIt + count;
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:count];
    for (; startIt != endIt; ++startIt)
    {
        [result addObject:*startIt];
    }
    
    return result;
}

- (NSArray<NSDate *> *)pointsBefore:(NSDate *)start count:(NSUInteger)count
{
    if (start == nil) THROW_INVALID_PARAM(start, nil);
    if (count == 0 || [start compare:*_data.cbegin()] == NSOrderedAscending) return @[];
    
    auto begin = _data.cbegin();
    auto finishIt = std::upper_bound(begin, _data.cend(), start, [](NSDate *lhs, NSDate *rhs) -> bool { return [lhs compare:rhs] == NSOrderedAscending; });
    NSUInteger availableCount = finishIt - begin;
    auto startIt = availableCount < count ? begin : finishIt - count;
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:count];
    for (; startIt != finishIt; ++startIt)
    {
        [result addObject:*startIt];
    }
    
    return result;
}

@end

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
#import <ChartEssentials/CETools.h>
#import <vector>

@implementation CEDateColumn
{
    std::vector<NSDate *> _data;
}

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
    _data.push_back(object);
}

- (void)addObjects:(NSArray<NSDate *> *)objects
{
    for (NSDate *date in objects)
    {
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
    THROW_NYI(nil);
}

- (NSArray<NSDate *> *)pointsAfter:(NSDate *)start count:(NSUInteger)count
{
    THROW_NYI(nil);
}

- (NSArray<NSDate *> *)pointsBefore:(NSDate *)start count:(NSUInteger)count
{
    THROW_NYI(nil);
}

@end

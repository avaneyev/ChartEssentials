//
//  CEDateRange.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateRange.h>
#import <ChartEssentials/CETools.h>

@interface CEIntervalDateRange : CEDateRange
- (instancetype)initWithDataInterval:(CEDateInterval *)dataInterval rangeInterval:(CEDateInterval *)rangeInterval quantity:(NSUInteger)quantity endDate:(NSDate *)endDate;
@end

@interface CEFixedDateRange : CEDateRange
- (instancetype)initWithDataInterval:(CEDateInterval *)dataInterval startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

@implementation CEDateRange
{
@protected
    CEDateInterval *_dataInterval;
}

+ (instancetype)alloc
{
    CEAlwaysAssert(self != [CEDateRange class]);
    return [super alloc];
}

- (instancetype)initWithInterval:(CEDateInterval *)interval
{
    CEAlwaysAssert(interval != nil);
    
    if (self = [super init])
    {
        _dataInterval = [interval copy];
    }
    return self;
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

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


#pragma mark - Properties

@synthesize dataInterval = _dataInterval;

- (NSDate *)startDate
{
    THROW_ABSTRACT(nil);
}

- (NSDate *)endDate
{
    THROW_ABSTRACT(nil);
}

#pragma mark - Methods

- (BOOL)coversDateRange:(CEDateRange *)dateRange
{
    if (dateRange == nil) return NO;
    if (dateRange == self) return YES;
    if (![_dataInterval isEqual:dateRange->_dataInterval]) return NO;
    
    NSDate *otherStart = dateRange.startDate;
    NSDate *ownStart = self.startDate;
    if ([otherStart compare:ownStart] == NSOrderedAscending) return NO;
    
    NSDate *otherEnd = dateRange.endDate;
    NSDate *ownEnd = self.endDate;
    
    return [otherEnd compare:ownEnd]  != NSOrderedDescending;
}

+ (instancetype)intervalRangeWithRangeInterval:(CEDateInterval *)rangeInterval rangeIntervalQuantity:(NSUInteger)quantity dataInterval:(CEDateInterval *)dataInterval anchoredToEndDate:(NSDate *)endDate
{
    if (rangeInterval == nil) THROW_INVALID_PARAM(rangeInterval, nil);
    if (quantity == 0) THROW_INVALID_PARAM(quantity, nil);
    if (dataInterval == nil) THROW_INVALID_PARAM(dataInterval, nil);
    
    return [[CEIntervalDateRange alloc] initWithDataInterval:dataInterval rangeInterval:rangeInterval quantity:quantity endDate:endDate];
}

+ (instancetype)fixedRangeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate dataInterval:(CEDateInterval *)dataInterval
{
    if (startDate == nil) THROW_INVALID_PARAM(startDate, nil);
    if (endDate == nil) THROW_INVALID_PARAM(endDate, nil);
    if (dataInterval == nil) THROW_INVALID_PARAM(dataInterval, nil);
    
    if ([endDate compare:startDate] == NSOrderedAscending)
    {
        NSDate *exchange = endDate;
        endDate = startDate;
        startDate = exchange;
    }
    
    return [[CEFixedDateRange alloc] initWithDataInterval:dataInterval startDate:startDate endDate:endDate];
}

@end

@implementation CEIntervalDateRange
{
    CEDateInterval *_rangeInterval;
    NSUInteger _quantity;
    NSDate *_endDate;
}

- (instancetype)initWithDataInterval:(CEDateInterval *)dataInterval rangeInterval:(CEDateInterval *)rangeInterval quantity:(NSUInteger)quantity endDate:(NSDate *)endDate
{
    if (self = [super initWithInterval:dataInterval])
    {
        _rangeInterval = [rangeInterval copy];
        _quantity = quantity;
        
        if (endDate)
        {
            _endDate = [dataInterval dateByRoundingToIntervalUp:YES date:endDate];
        }
    }
    return self;
}

- (NSDate *)startDate
{
    NSDate *endDate = self.endDate;
    return [_rangeInterval dateByAddingIntervals:-_quantity toDate:endDate];
}

- (NSDate *)endDate
{
    return _endDate ?: [_dataInterval dateByRoundingToIntervalUp:YES date:[NSDate date]];
}

@end

@implementation CEFixedDateRange
{
    NSDate *_startDate;
    NSDate *_endDate;
}

- (instancetype)initWithDataInterval:(CEDateInterval *)dataInterval startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    if (self = [super initWithInterval:dataInterval])
    {
        _startDate = [dataInterval dateByRoundingToIntervalUp:NO date:startDate];
        _endDate = [dataInterval dateByRoundingToIntervalUp:YES date:endDate];
    }
    return self;
}

@synthesize startDate = _startDate;
@synthesize endDate = _endDate;

@end

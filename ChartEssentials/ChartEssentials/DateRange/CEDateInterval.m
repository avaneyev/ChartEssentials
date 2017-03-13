//
//  CEDateInterval.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateInterval.h>
#import <ChartEssentials/CETools.h>

@implementation CEDateInterval
{
    NSCalendarUnit _unit;
    NSUInteger _quantity;
}

- (instancetype)initWithUnit:(NSCalendarUnit)unit quantity:(NSUInteger)quantity
{
    if (quantity == 0) THROW_INVALID_PARAM(quantity, nil);
    if (unit != NSCalendarUnitMinute &&
        unit != NSCalendarUnitHour &&
        unit != NSCalendarUnitDay &&
        unit != NSCalendarUnitWeekOfYear &&
        unit != NSCalendarUnitMonth &&
        unit != NSCalendarUnitYear)
    {
        THROW_INVALID_PARAM(unit, nil);
    }
    
    if (self = [super init])
    {
        _unit = unit;
        _quantity = quantity;
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


#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
    if (object == self) return YES;
    if (![object isKindOfClass:[CEDateInterval class]]) return NO;
    
    CEDateInterval *otherInterval = object;
    return _unit == otherInterval->_unit && _quantity ==  otherInterval->_quantity;
}

- (NSUInteger)hash
{
    return 37 * (NSUInteger)_unit + _quantity;
}


#pragma mark - Properties

@synthesize unit = _unit;
@synthesize quantity = _quantity;


#pragma mark - Methods

+ (NSCalendar *)_calendar
{
    static NSCalendar *_calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    });
    return _calendar;
}

- (NSDate *)dateByAddingIntervals:(NSInteger)intervals toDate:(NSDate *)date
{
    
    return [[CEDateInterval _calendar] dateByAddingUnit:_unit value:_quantity * intervals toDate:date options:0];
}

- (NSDate *)dateByRoundingToIntervalUp:(BOOL)up date:(NSDate *)date
{
    // TODO: for some units(like minute or hour) rounding does not have to involve a calendar
    // Date can be rounded to minutes using time intervals.
    // With hours it's a bit more complicated because some time zones have fractional offset from GMT.
    
    NSCalendarUnit queryUnits = 0;
    NSCalendarUnit subunitToReset = 0;
    
    switch (_unit) {
        case NSCalendarUnitMinute:
            queryUnits = NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitEra;
            break;
        case NSCalendarUnitHour:
            queryUnits = NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitEra;
            break;
        case NSCalendarUnitDay:
            queryUnits = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitEra;
            break;
        case NSCalendarUnitWeekOfYear:
            queryUnits = NSCalendarUnitWeekOfYear|NSCalendarUnitYear|NSCalendarUnitEra;
            subunitToReset = NSCalendarUnitWeekday;
            break;
        case NSCalendarUnitMonth:
            queryUnits = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitEra;
            subunitToReset = NSCalendarUnitDay;
            break;
        case NSCalendarUnitYear:
            queryUnits = NSCalendarUnitYear|NSCalendarUnitEra;
            subunitToReset = NSCalendarUnitDay;
            break;
        default:
            THROW_INCONSISTENCY(nil);
            break;
    }
    
    NSCalendar *calendar = [CEDateInterval _calendar];
    NSDateComponents *components = [calendar components:queryUnits fromDate:date];
    
    if (subunitToReset != 0)
    {
        NSRange minimumResetUnitRange = [calendar minimumRangeOfUnit:subunitToReset];
        [components setValue:minimumResetUnitRange.location forComponent:subunitToReset];
    }
    
    if (_quantity > 1)
    {
        NSInteger unitQuantity = [components valueForComponent:_unit];
        NSRange minimumUnitRange = [calendar minimumRangeOfUnit:_unit];
        
        // Rounding needs to take into account the minimum unit quantity.
        // Minutes are 0-60, and rounding 3 minutes to 5 minute interval will result in 0;
        // Days, however, start with one (ranges are 1-28 to 1-31) and rounding 3 days to 5 day interval
        // should not produce a 0, but should produce 1.
        NSInteger roundedUnitQuantity = (unitQuantity / _quantity) * _quantity + minimumUnitRange.location;
        if (unitQuantity != roundedUnitQuantity)
        {
            [components setValue:roundedUnitQuantity forComponent:_unit];
        }
    }
    
    NSDate *dateRoundedDown = [calendar dateFromComponents:components];
    
    if (!up || [dateRoundedDown isEqualToDate:date]) return dateRoundedDown;
    
    return [self dateByAddingIntervals:1 toDate:dateRoundedDown];
}

@end

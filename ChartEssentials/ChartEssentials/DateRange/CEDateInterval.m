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
    NSCalendarUnit queryUnits = 0;
    
    switch (_unit) {
        case NSCalendarUnitMinute:
            queryUnits = NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
            break;
        case NSCalendarUnitHour:
            queryUnits = NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
            break;
        case NSCalendarUnitDay:
            queryUnits = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
            break;
        case NSCalendarUnitWeekOfYear:
            queryUnits = NSCalendarUnitWeekOfYear|NSCalendarUnitYear;
            break;
        case NSCalendarUnitMonth:
            queryUnits = NSCalendarUnitMonth|NSCalendarUnitYear;
            break;
        case NSCalendarUnitYear:
            queryUnits = NSCalendarUnitYear;
            break;
        default:
            THROW_INCONSISTENCY(nil);
            break;
    }
    
    NSCalendar *calendar = [CEDateInterval _calendar];
    NSDateComponents *components = [calendar components:queryUnits fromDate:date];
    if (_quantity > 1)
    {
        NSInteger unitQuantity = [components valueForComponent:_unit];
        NSInteger roundedUnitQuantity = (unitQuantity / _quantity) * _quantity;
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

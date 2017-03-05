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
    CEAlwaysAssert(quantity > 0);
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

#pragma mark - Properties

@synthesize unit = _unit;
@synthesize quantity = _quantity;

@end

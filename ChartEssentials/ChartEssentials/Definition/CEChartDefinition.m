//
//  CEChartDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartDefinition.h>

@implementation CEChartDefinition
{
    NSArray<CESubchartDefinition *> *_subcharts;
    CEHorizontalAxisDefinition *_horizontalAxis;
    NSDictionary<NSString *, CEInstrumentDefinition *> *_instruments;
    NSDictionary<NSString *, CEDateIndexedTable *> *_dataTables;
}

- (instancetype)initWithSubcharts:(NSArray<CESubchartDefinition *> *)subcharts horizontalAxis:(CEHorizontalAxisDefinition *)horizontalAxis
{
    if (self = [super init])
    {
        _subcharts = [subcharts copy];
        _horizontalAxis = horizontalAxis;
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


#pragma mark - Properties

@synthesize subcharts = _subcharts;
@synthesize horizontalAxis = _horizontalAxis;
@synthesize instruments = _instruments;
@synthesize dataTables = _dataTables;

@end

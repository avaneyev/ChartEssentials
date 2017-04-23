//
//  CESubchartModel.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESubchartModel.h>
#import "CESubchartModel+Private.h"
#import "CEChartModel.h"
#import <ChartEssentials/CESubchartDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CESubchartModel
{
    CESubchartDefinition *_definition;
    __weak CEChartModel *_chartModel;
}

- (instancetype)initWithDefinition:(CESubchartDefinition *)definition chartModel:(CEChartModel *)chartModel
{
    CEAssert(definition != nil);
    CEAssert(chartModel != nil);

    if (self = [super init])
    {
        _definition = definition;
        _chartModel = chartModel;
    }
    return self;
}

@synthesize definition = _definition;
@synthesize chartModel = _chartModel;

@end

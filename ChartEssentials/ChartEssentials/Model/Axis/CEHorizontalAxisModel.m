//
//  CEHorizontalAxisModel.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import "CEHorizontalAxisModel.h"
#import "CEChartModel.h"
#import <ChartEssentials/CEHorizontalAxisDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEHorizontalAxisModel
{
    CEHorizontalAxisDefinition *_definition;
    __weak CEChartModel *_chartModel;
}

- (instancetype)initWithDefinition:(CEHorizontalAxisDefinition *)definition chartModel:(CEChartModel *)chartModel
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

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
#import <ChartEssentials/CEVerticalAxisDefinition.h>
#import <ChartEssentials/CEVerticalAxisModel.h>

@implementation CESubchartModel
{
    CESubchartDefinition *_definition;
    __weak CEChartModel *_chartModel;
    
    NSMutableArray<CEVerticalAxisModel *> *_verticalAxes;
}

- (instancetype)initWithDefinition:(CESubchartDefinition *)definition chartModel:(CEChartModel *)chartModel
{
    CEAssert(definition != nil);
    CEAssert(chartModel != nil);

    if (self = [super init])
    {
        _definition = definition;
        _chartModel = chartModel;
        
        NSArray<CEVerticalAxisDefinition *> *axisDefinitions = definition.verticalAxes;
        NSUInteger axisCount = axisDefinitions.count;
        _verticalAxes = [[NSMutableArray alloc] initWithCapacity:axisCount];
        
        NSMutableDictionary<NSString *, CEVerticalAxisModel *> *axisMap = [[NSMutableDictionary alloc] initWithCapacity:axisCount];
        
        for (CEVerticalAxisDefinition *axisDefinition in axisDefinitions)
        {
            NSString *axisId = axisDefinition.axisId;
            if ([axisMap objectForKey:axisId] != nil)
            {
                NSString *reason = [NSString stringWithFormat:@"Axis ID \"%@\" is not unique inside subchart definition %@", axisId, definition];
                THROW_INCONSISTENCY(@{ NSLocalizedDescriptionKey: reason });
            }
            CEVerticalAxisModel *axisModel = [[CEVerticalAxisModel alloc] initWithDefinition:axisDefinition subchartModel:self];
            [_verticalAxes addObject:axisModel];
            [axisMap setObject:axisModel forKey:axisId];
        }
    }
    return self;
}

@synthesize definition = _definition;
@synthesize chartModel = _chartModel;

- (NSString *)subchartId
{
    return _definition.subchartId;
}

- (NSArray<CEVerticalAxisModel *> *)axes
{
    return [_verticalAxes copy];
}

@end

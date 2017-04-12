//
//  CEChartView.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartView.h>
#import <ChartEssentials/CEPlatformDefinitions.h>
#import "CEChartModel.h"

@implementation CEChartView
{
    CEChartDefinition *_definition;
    CEChartModel *_model;
    
    __weak id<CEChartViewDelegate> _delegate;
}

- (instancetype)initWithFrame:(CERect)frameRect
{
    if (self = [super initWithFrame:frameRect])
    {
        _model = [[CEChartModel alloc] initWithChartView:self];
    }
    return self;
}

@synthesize delegate = _delegate;

@synthesize definition = _definition;

- (void)setDefinition:(CEChartDefinition *)definition
{
    if (_definition != definition)
    {
        _definition = definition;
        // TODO: update subscriptions, redraw the chart.
    }
}

@end

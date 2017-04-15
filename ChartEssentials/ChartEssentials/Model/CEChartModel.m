//
//  CEChartModel.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import "CEChartModel.h"
#import <ChartEssentials/CEChartView.h>
#import <ChartEssentials/CETools.h>

@implementation CEChartModel
{
    __weak CEChartView *_chartView;
    CEChartDefinition *_definition;
    __weak id<CEChartViewDelegate> _delegate;
}

- (instancetype)initWithChartView:(CEChartView *)view
{
    CEAssert(view != nil);
    
    if (self = [super init])
    {
        _chartView = view;
    }
    return self;
}

#pragma mark - Properties

@synthesize view = _chartView;
@synthesize definition = _definition;
@synthesize delegate = _delegate;

@end

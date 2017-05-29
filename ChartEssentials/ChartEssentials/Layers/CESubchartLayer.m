//
//  CESubchartLayer.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESubchartLayer.h>
#import "CESubchartLayer+Private.h"
#import <ChartEssentials/CESubchartModel.h>
#import <ChartEssentials/CETools.h>

@implementation CESubchartLayer
{
    __weak CEChartView *_chartView;
    CESubchartModel *_model;
}

- (instancetype)initWithScale:(CGFloat)scale chartView:(CEChartView *)chartView model:(CESubchartModel *)model
{
    CEAssert(chartView != nil);
    CEAssert(model != nil);
    
    if (self = [super initWithModel:model scale:scale])
    {
        _chartView = chartView;
        model = _model;
    }
    return self;
}

@end

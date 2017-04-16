//
//  CEVerticalAxisModel.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import "CEVerticalAxisModel.h"
#import "CESubchartModel.h"
#import <ChartEssentials/CEVerticalAxisDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEVerticalAxisModel
{
    CEVerticalAxisDefinition *_definition;
    __weak CESubchartModel *_subchartModel;
}

- (instancetype)initWithDefinition:(CEVerticalAxisDefinition *)definition subchartModel:(CESubchartModel *)subchartModel
{
    CEAssert(definition != nil);
    CEAssert(subchartModel != nil);
    
    if (self = [super init])
    {
        _definition = definition;
        _subchartModel = subchartModel;
    }
    return self;
}

@synthesize definition = _definition;
@synthesize subchartModel = _subchartModel;


@end

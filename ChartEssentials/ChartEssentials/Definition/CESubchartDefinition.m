//
//  CESubchartDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESubchartDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CESubchartDefinition
{
    NSString *_subchartId;
}

- (instancetype)initWithId:(NSString *)subchartId
{
    CEAlwaysAssert(subchartId != nil);
    
    if (self = [super init])
    {
        _subchartId = [subchartId copy];
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

@synthesize subchartId = _subchartId;

@end

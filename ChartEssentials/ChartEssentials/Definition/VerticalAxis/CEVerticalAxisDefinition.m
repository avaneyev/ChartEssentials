//
//  CEVerticalAxisDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEVerticalAxisDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEVerticalAxisDefinition

- (instancetype)initWithId:(NSString *)axisId
{
    CEAlwaysAssert(axisId != nil);
    if (self = [super init])
    {
        _axisId = [axisId copy];
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

@synthesize axisId = _axisId;
@synthesize caption = _caption;
@synthesize unitName = _unitName;

@end

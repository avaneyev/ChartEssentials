//
//  CEDrawingType.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDrawingType.h>
#import <ChartEssentials/CEColorScheme.h>
#import <ChartEssentials/CETools.h>

NSString *CEDrawingTypeLineName = @"LineDrawing";
NSString *CEDrawingTypeBarName = @"BarDrawing";
NSString *CEDrawingTypeAreaName = @"AreaDrawing";
NSString *CEDrawingTypeOHLCName = @"OHLCDrawing";
NSString *CEDrawingTypeCandleName = @"CandleDrawing";
NSString *CEDrawingTypeStepLineName = @"StepLineDrawing";

@implementation CEDrawingType
{
    CEColorScheme *_colorScheme;
}

- (instancetype)initWithColorScheme:(CEColorScheme *)colorScheme
{
    CEAlwaysAssert(colorScheme != nil);

    if (self = [super init])
    {
        _colorScheme = [colorScheme copy];
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

@synthesize colorScheme = _colorScheme;

- (NSString *)typeName
{
    THROW_ABSTRACT(nil);
}

@end

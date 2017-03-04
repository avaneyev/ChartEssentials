//
//  CEBarDrawingType.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEBarDrawingType.h>
#import <ChartEssentials/CETools.h>

@implementation CEBarDrawingType

- (instancetype)initWithColumn:(NSString *)column colorScheme:(CEColorScheme *)colorScheme
{
    CEAlwaysAssert(column != nil);
    
    if (self = [super initWithColorScheme:colorScheme])
    {
        _column = [column copy];
    }
    return self;
}

@synthesize column = _column;

- (NSString *)typeName
{
    return CEDrawingTypeBarName;
}

@end

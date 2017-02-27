//
//  CELineDrawingType.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CELineDrawingType.h>
#import <ChartEssentials/CELineStyle.h>

@implementation CELineDrawingType
{
    NSString *_column;
    CELineStyle *_lineStyle;
}

- (instancetype)initWithColumn:(NSString *)column colorScheme:(CEColorScheme *)colorScheme lineStyle:(CELineStyle *)lineStyle
{
     if (self = [super initWithColorScheme:colorScheme])
     {
         _column = [column copy];
         _lineStyle = [lineStyle copy];
     }
    return self;
}

@synthesize column = _column;
@synthesize lineStyle = _lineStyle;

- (NSString *)typeName
{
    return CEDrawingTypeLineName;
}

@end

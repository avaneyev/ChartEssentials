//
//  CESingleColorScheme.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CESingleColorScheme.h>
#import <ChartEssentials/CETools.h>
#import "CEColorScheme+Private.h"
#import "CEImageTools.h"

@implementation CESingleColorScheme
{
    CEColor *_color;
}

- (instancetype)initWithColor:(CEColor *)color
{
    if (self = [super init])
    {
        _color = [color copy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}


- (void)_drawSchemeInContext:(CGContextRef)context rect:(CGRect)rect
{
    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    CGContextFillRect(context, rect);
}

- (CEImage *)_drawSchemeWithMask:(CEImage *)mask
{
    CEAlwaysAssert(mask != nil);
    return [mask _imageWithOverlayColor:_color];
}


#pragma mark - Properties

@synthesize color = _color;

@end

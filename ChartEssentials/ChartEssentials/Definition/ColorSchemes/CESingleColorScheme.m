//
//  CESingleColorScheme.m
//  ChartEssentials
//
//  Created by Anton Vaneev on 2/15/17.
//  Copyright © 2017 Anton Vaneev. All rights reserved.
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
    return _CEMaskedImageWithOverlayColor(mask, _color);
}

#pragma mark - Properties

@synthesize color = _color;

@end

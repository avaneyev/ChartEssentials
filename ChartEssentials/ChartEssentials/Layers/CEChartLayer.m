//
//  CEChartLayer.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEChartLayer.h>

@implementation CEChartLayer
{
    CALayer *_layer;
}

- (instancetype)initWithScale:(CGFloat)scale
{
    if (self = [super init])
    {
        _layer = [[self class] createLayer];
        _layer.delegate = self;
        _layer.masksToBounds = YES;
        _layer.contentsScale = scale;
    }
    return self;
}

+ (CALayer *)createLayer
{
    return [CALayer layer];
}


#pragma mark - Properties

@synthesize layer = _layer;


#pragma mark - Layer delegate methods

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    // By default, no actions on layers. Subclasses may override piecemeal, but in most cases should not.
    return [NSNull null];
}

@end

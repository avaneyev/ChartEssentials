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
#import <ChartEssentials/CETools.h>

@implementation CEChartLayer
{
    CALayer *_layer;
    __weak CEChartLayer *_superlayer;
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
@synthesize superlayer = _superlayer;


#pragma mark - Layer delegate methods

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    // By default, no actions on layers. Subclasses may override piecemeal, but in most cases should not.
    return [NSNull null];
}


#pragma mark - Other layer methods

- (void)addSublayer:(CEChartLayer *)layer
{
    if (!layer)
    {
        CELog(@"Attempting to add a nil layer");
        return;
    }
    [_layer addSublayer:layer->_layer];
    layer->_superlayer = self;
}

- (void)insertSublayer:(CEChartLayer *)layer atIndex:(unsigned int)idx
{
    if (!layer)
    {
        CELog(@"Attempting to insert a nil layer");
        return;
    }
    [_layer insertSublayer:layer->_layer atIndex:idx];
    layer->_superlayer = self;
}

- (void)removeFromSuperlayer
{
    [_layer removeFromSuperlayer];
    _superlayer = nil;
}



@end

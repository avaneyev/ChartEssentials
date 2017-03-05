//
//  CEDualColorScheme.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDualColorScheme.h>
#import <ChartEssentials/CETools.h>
#import "CEColorScheme+Private.h"

@implementation CEDualColorScheme
{
    CEColor *_upColor;
    CEColor *_downColor;
    CEColor *_neutralColor;
}

- (instancetype)initWithUpColor:(CEColor *)upColor downColor:(CEColor *)downColor neutralColor:(CEColor *)neutralColor
{
    CEAlwaysAssert(upColor != nil);
    CEAlwaysAssert(downColor != nil);
    CEAlwaysAssert(neutralColor != nil);
    
    if (self = [super init])
    {
        _upColor = upColor;
        _neutralColor = neutralColor;
        _downColor = downColor;
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
    CGRect halfRect = rect;
    halfRect.size.width = cetrunc(rect.size.width / 2);
    [_upColor set];
    CGContextFillRect(context, halfRect);
    [_downColor set];
    halfRect.origin.x = halfRect.size.width;
    halfRect.size.width = rect.size.width - halfRect.size.width;
    CGContextFillRect(context, halfRect);
}


#if TARGET_OS_IPHONE

- (UIImage *)_drawSchemeWithMask:(UIImage *)mask
{
    CGSize maskSize = mask.size;
    CGRect rect = { CGPointZero, maskSize };

    // Graphics renderer is the recommended way to make images, but it is only available starting iOS 10.
    if ([UIGraphicsImageRenderer class])
    {
        UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
        format.scale = mask.scale;
        
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:maskSize format:format];
        
        return [renderer imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
            [mask drawInRect:rect];

            CGContextSetBlendMode(rendererContext.CGContext, kCGBlendModeSourceIn);

            CGRect halfRect = { CGPointZero, { .width = cetrunc(maskSize.width / 2), .height = maskSize.height } };
            
            [self->_upColor setFill];
            [rendererContext fillRect:halfRect];
            
            halfRect.origin.x = halfRect.size.width;
            halfRect.size.width = maskSize.width - halfRect.size.width;
            
            [self->_downColor setFill];
            [rendererContext fillRect:halfRect];
        }];
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(maskSize, NO, mask.scale);
        
        [mask drawInRect:rect];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetBlendMode(context, kCGBlendModeSourceIn);
        
        CGRect halfRect = { CGPointZero, { .width = cetrunc(maskSize.width / 2), .height = maskSize.height } };
        
        CGContextSetFillColorWithColor(context, _upColor.CGColor);
        CGContextFillRect(context, halfRect);
        
        halfRect.origin.x = halfRect.size.width;
        halfRect.size.width = maskSize.width - halfRect.size.width;
        
        CGContextSetFillColorWithColor(context, _downColor.CGColor);
        CGContextFillRect(context, halfRect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
}

#endif


#pragma mark - Properties

@synthesize upColor = _upColor;
@synthesize downColor = _downColor;
@synthesize neutralColor = _neutralColor;

@end

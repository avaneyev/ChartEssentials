//
//  CEImageTools.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import "CEImageTools.h"

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

UIImage *_CEMaskedImageWithOverlayColor(UIImage *mask, UIColor *color)
{
    CGSize imageSize = mask.size;
    CGRect rect = { CGPointZero, imageSize };
    
    if (UIGraphicsBeginImageContextWithOptions)
    {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, mask.scale);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    [mask drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

NSImage *_CEMaskedImageWithOverlayColor(NSImage *mask, NSColor *color)
{
    return nil;
}
#endif


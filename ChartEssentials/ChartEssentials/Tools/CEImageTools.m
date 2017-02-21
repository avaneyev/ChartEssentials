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

@implementation UIImage (CEImageTools)

- (UIImage *)_imageWithOverlayColor:(UIColor *)color
{
    CGSize imageSize = self.size;
    CGRect rect = { CGPointZero, imageSize };
    
    // Graphics renderer is the recommended way to make images, but it is only available starting iOS 10.
    if ([UIGraphicsImageRenderer class])
    {
        UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
        format.scale = mask.scale;
        
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:maskSize format:format];
        
        return [renderer imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
            [mask drawInRect:rect];
            
            [color setFill];
            [rendererContext fillRect:rect];
            
            CGContextSetBlendMode(rendererContext.CGContext, kCGBlendModeSourceIn);
        }];
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, self.scale);
        
        [self drawInRect:rect];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetBlendMode(context, kCGBlendModeSourceIn);
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}

@end

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

- (NSImage *)_imageWithOverlayColor:(NSColor *)color
{
    return nil;
}

#endif


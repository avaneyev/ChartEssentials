//
//  CEColorScheme+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEColorScheme.h>
#import <ChartEssentials/CEPlatformDefinitions.h>

#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEColorScheme ()

/**
 Draws the color scheme in a graphics context in a specific rect.
 */
- (void)_drawSchemeInContext:(CGContextRef)context rect:(CGRect)rect;

/**
 Draws a scheme masked by an image. Scheme will be used for background of the mask image.
 */
- (CEImage *)_drawSchemeWithMask:(CEImage *)mask;

@end

NS_ASSUME_NONNULL_END

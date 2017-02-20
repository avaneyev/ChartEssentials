//
//  CEImageTools.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEPlatformDefinitions.h>

#if TARGET_OS_IPHONE

@interface UIImage (CEImageTools)
- (nonnull UIImage *)_imageWithOverlayColor:(nonnull UIColor *)color;
@end

#elif TARGET_OS_MAC

@interface NSImage (CEImageTools)
- (nonnull NSImage *)_imageWithOverlayColor:(nonnull NSColor *)color;
@end

#endif

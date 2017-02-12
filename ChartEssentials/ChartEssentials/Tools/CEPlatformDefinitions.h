//
//  CEPlatformDefinitions.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#define CEColor     UIColor
#define CEFont      UIFont
#define CEImage     UIImage

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

#define CEColor     NSColor
#define CEFont      NSFont
#define CEImage     NSImage

#endif

#if defined(__LP64__) && __LP64__

#define cetrunc(x) trunc(x)
#define cefabs(x) fabs(x)
#define cefloor(x) floor(x)

#else

#define cetrunc(x) truncf(x)
#define cefabs(x) fabsf(x)
#define cefloor(x) floorf(x)

#endif

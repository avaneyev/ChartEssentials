//
//  CEChartView.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEPlatformDefinitions.h>

#if TARGET_OS_IPHONE
@interface CEChartView : UIView
#elif TARGET_OS_MAC
@interface CEChartView : NSView
#endif

@end

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

@class CEChartView;
@class CEChartDefinition;

/**
 Chart view delegate can be used to get certain events about the chart activity, 
 such as need for more data or presenting a menu.
 */
@protocol CEChartViewDelegate <NSObject>

@end


#if TARGET_OS_IPHONE
@interface CEChartView : UIView
#elif TARGET_OS_MAC
@interface CEChartView : NSView
#else
#error Unsupported platform
#endif

/**
 Definition describes the chart that should be rendered.
 Updates to the definition object will cause chart to re-draw.
 */
@property (nonatomic, strong) CEChartDefinition *definition;

@property (nonatomic, weak) id<CEChartViewDelegate> delegate;

@end

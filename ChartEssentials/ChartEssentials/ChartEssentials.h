//
//  ChartEssentials.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

#endif

//! Project version number for ChartEssentials.
FOUNDATION_EXPORT double ChartEssentialsVersionNumber;

//! Project version string for ChartEssentials.
FOUNDATION_EXPORT const unsigned char ChartEssentialsVersionString[];

#import <ChartEssentials/CETools.h>
#import <ChartEssentials/CEPlatformDefinitions.h>

// Data table
#import <ChartEssentials/CEDateColumn.h>
#import <ChartEssentials/CEValueColumn.h>
#import <ChartEssentials/CEDateIndexedTable.h>

// Chart definition
#import <ChartEssentials/CEChartDefinition.h>
#import <ChartEssentials/CESubchartDefinition.h>
#import <ChartEssentials/CEHorizontalAxisDefinition.h>
#import <ChartEssentials/CEInstrumentDefinition.h>

#import <ChartEssentials/CEVerticalAxisDefinition.h>

#import <ChartEssentials/CEStudyDefinition.h>
#import <ChartEssentials/CEDrawingDefinition.h>
#import <ChartEssentials/CEDrawingType.h>
#import <ChartEssentials/CELineStyle.h>
#import <ChartEssentials/CELineDrawingType.h>
#import <ChartEssentials/CECandleDrawingType.h>
#import <ChartEssentials/CEOHLCDrawingType.h>
#import <ChartEssentials/CEBarDrawingType.h>

#import <ChartEssentials/CEColorScheme.h>
#import <ChartEssentials/CESingleColorScheme.h>
#import <ChartEssentials/CEDualColorScheme.h>

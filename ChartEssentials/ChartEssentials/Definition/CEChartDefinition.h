//
//  CEChartDefinition.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CESubchartDefinition;
@class CEHorizontalAxisDefinition;
@class CEInstrumentDefinition;

@class CEDateIndexedTable;

/**
 Root object of a chart definition, describes a whole chart.
 A chart definition has to have data tables assigned to it in order for it to be rendered.
 A definition without data tables only describes the basic structure of the chart.
 Chart definition is encoded and decoded without data.
 */
@interface CEChartDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

/**
 Initializes a chart defition with a list of subcharts (one or more) and a horizontal axis definition.
 @param subcharts a list of 1 or more subcharts that will make up the whole chart.
 @param horizontalAxis horizontal axis shared between all subcharts.
 */
- (instancetype)initWithSubcharts:(NSArray<CESubchartDefinition *> *)subcharts
                   horizontalAxis:(CEHorizontalAxisDefinition *)horizontalAxis;

/**
 A list of subcharts.
 */
@property (nonatomic, readonly) NSArray<CESubchartDefinition *> *subcharts;
/**
 A horizontal axis definition.
 */
@property (nonatomic, readonly) CEHorizontalAxisDefinition *horizontalAxis;

/**
 A dictionary of instruments presented in a chart.
 */
@property (nonatomic, readonly, nullable) NSDictionary<NSString *, CEInstrumentDefinition *> *instruments;

/**
 A dictionary of data tables that will be used to render a chart.
 */
@property (nonatomic, readwrite, nullable) NSDictionary<NSString *, CEDateIndexedTable *> *dataTables;

@end

NS_ASSUME_NONNULL_END

//
//  CESubchartDefinition.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

@class CEVerticalAxisDefinition;
@class CEStudyDefinition;
@class CEDrawingDefinition;

NS_ASSUME_NONNULL_BEGIN

/**
 Subchart definition describes a section of the chart, which has one or more vertical axes, legend, plots and so on.
 */
@interface CESubchartDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithId:(NSString *)subchartId NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 Subchart identifier used to reference the subchart elsewhere.
 */
@property (nonatomic, readonly) NSString *subchartId;

/**
 A list of vertical axes belonging to the subchart.
 An axis order related to other axes determines its position on the subchart.
 Axes are placed from inside to outside, alternating sides, right first.
 For example, if there are 3 axes, they are placed | 2 | ------------ | 1 | 3 |
 */
@property (nonatomic, readonly) NSArray<CEVerticalAxisDefinition *> *verticalAxes;

/**
 A dictionary of studies drawn on a subchart.
 Studies are not ordered, drawing order will be determined by the drawings.
 */
@property (nonatomic, readonly) NSDictionary<NSString *,CEStudyDefinition *> *studies;

/**
 A list of drawings rendered on a subchart.
 Drawing order defines z-order of the drawings, last being top-most (closest to the viewer).
 */
@property (nonatomic, readonly) NSArray<CEDrawingDefinition *> *drawings;

@end

NS_ASSUME_NONNULL_END

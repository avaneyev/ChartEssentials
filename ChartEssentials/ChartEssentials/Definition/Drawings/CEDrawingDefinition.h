//
//  CEDrawingDefinition.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Describes a drawing, graphical representation of time series data.
 A drawing definition consists of general properties (ID, study that drawing belongs to, etc.)
 and  style-dependent details, which vary for different kinds of drawings.
 For example, a line drawing only needs line style, while mountain drawing may also have a gradient.
 */
@interface CEDrawingDefinition : NSObject<NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithId:(NSString *)drawingId studyId:(NSString *)studyId NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 Drawing identifier - a string used by other objects to reference the drawing.
 */
@property (nonatomic, readonly) NSString *drawingId;

/**
 Study identifier - an identifier of the study that drawing belongs to.
 */
@property (nonatomic, readonly) NSString *studyId;

/**
 Sets the drawing as hidden. Hidden drawings are not displayed on the chart.
 */
@property (readwrite, assign) BOOL hidden;

@end

NS_ASSUME_NONNULL_END

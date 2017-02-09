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

- (instancetype)initWithId:(NSString *)drawingId NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSString *drawingId;

@end

NS_ASSUME_NONNULL_END

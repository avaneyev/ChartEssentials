//
//  CELineDrawingType.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDrawingType.h>

@class CELineStyle;

NS_ASSUME_NONNULL_BEGIN

/**
 Line drading type describes a line drawing.
 Line drawing requires a data column and a line style to draw a line.
 */
@interface CELineDrawingType : CEDrawingType

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithColorScheme:(CEColorScheme *)colorScheme NS_UNAVAILABLE;

- (instancetype)initWithColumn:(NSString *)column colorScheme:(CEColorScheme *)colorScheme lineStyle:(CELineStyle *)lineStyle;

// Column name to use for rendering the line.
@property (nonatomic, copy) NSString *column;

@property (nonatomic) CELineStyle *lineStyle;

@end

NS_ASSUME_NONNULL_END

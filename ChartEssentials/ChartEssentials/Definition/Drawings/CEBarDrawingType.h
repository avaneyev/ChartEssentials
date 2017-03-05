//
//  CEBarDrawingType.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDrawingType.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEBarDrawingType : CEDrawingType

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithColorScheme:(CEColorScheme *)colorScheme NS_UNAVAILABLE;

- (instancetype)initWithColumn:(NSString *)column colorScheme:(CEColorScheme *)colorScheme;

// Column name to use as data source for line points.
@property (nonatomic, copy) NSString *column;

// Bar fill opacity
@property (nonatomic, assign) CGFloat opacity;

@end

NS_ASSUME_NONNULL_END

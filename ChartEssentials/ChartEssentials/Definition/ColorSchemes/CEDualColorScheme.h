//
//  CEDualColorScheme.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEColorScheme.h>
#import <ChartEssentials/CEPlatformDefinitions.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Concrete color scheme for dual color drawing
 */
@interface CEDualColorScheme : CEColorScheme

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUpColor:(CEColor *)upColor downColor:(CEColor *)downColor neutralColor:(CEColor *)neutralColor NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) CEColor *upColor;
@property (nonatomic, readonly) CEColor *neutralColor;
@property (nonatomic, readonly) CEColor *downColor;

@end

NS_ASSUME_NONNULL_END

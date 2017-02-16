//
//  CESingleColorScheme.h
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
 Concrete color scheme for single color drawing
 */
@interface CESingleColorScheme : CEColorScheme

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithColor:(CEColor *)color NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) CEColor *color;

@end

NS_ASSUME_NONNULL_END

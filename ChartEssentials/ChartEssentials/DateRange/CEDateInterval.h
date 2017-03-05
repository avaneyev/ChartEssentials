//
//  CEDateInterval.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEDateInterval : NSObject<NSCopying, NSCoding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUnit:(NSCalendarUnit)unit quantity:(NSUInteger)quantity NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSCalendarUnit unit;
@property (nonatomic, readonly) NSUInteger quantity;

@end

NS_ASSUME_NONNULL_END

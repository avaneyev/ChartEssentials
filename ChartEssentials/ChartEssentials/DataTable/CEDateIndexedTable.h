//
//  CEDateIndexedTable.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CEDateColumn, CEValueColumn;

/**
 Data table class for storing time series of column-based data.
 A time series table has a date column and one or more value column.
 */
@interface CEDateIndexedTable : NSObject

- (nullable instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDateColumn:(CEDateColumn *)dateColumn valueColumns:(NSDictionary<NSString *, CEValueColumn *> *)valueColumns NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) CEDateColumn *dateColumn;
@property (nonatomic, readonly) NSSet<NSString *> *valueColumnNames;

- (nullable CEValueColumn *)columnForName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

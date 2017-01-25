//
//  CEDateColumn.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEDateColumn : NSObject<NSCopying>

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly, retain, nullable) NSDate *first;
@property (nonatomic, readonly, retain, nullable) NSDate *last;

- (void)addObject:(NSDate *)object;
- (void)addObjects:(NSArray<NSDate *> *)objects;

- (NSDate *)objectAtIndex:(NSUInteger)index;
- (NSArray<NSDate *> *)objectsInRange:(NSRange)range;

- (NSRange)rangeForStart:(NSDate *)start finish:(NSDate *)finish;
- (NSArray<NSDate *> *)pointsBefore:(NSDate *)start count:(NSUInteger)count;
- (NSArray<NSDate *> *)pointsAfter:(NSDate *)start count:(NSUInteger) count;

@end

NS_ASSUME_NONNULL_END

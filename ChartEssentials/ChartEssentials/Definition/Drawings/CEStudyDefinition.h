//
//  CEStudyDefinition.h
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
 A study is a logical group of one or more drawings which share the same axis.
 For example:
 - daily close price is a study that consists of one drawing;
 - MACD (moving average convergence divergence) is a study that consists of 3 drawings
   (MACD, signal, histogram), all or just some of which may be rendered on a chart.
 */
@interface CEStudyDefinition : NSObject<NSCoding>

- (instancetype)initWithId:(NSString *)studyId;

/**
 Study identifier - a string that is used by other definition objects to reference the study.
 */
@property (nonatomic, readonly) NSString *studyId;


@end

NS_ASSUME_NONNULL_END

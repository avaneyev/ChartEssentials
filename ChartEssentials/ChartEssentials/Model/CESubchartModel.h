//
//  CESubchartModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CESubchartDefinition;

@interface CESubchartModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) CESubchartDefinition *definition;

@end

NS_ASSUME_NONNULL_END

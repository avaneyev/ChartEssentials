//
//  CEVerticalAxisModel.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CESubchartModel;
@class CEVerticalAxisDefinition;

@interface CEVerticalAxisModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDefinition:(CEVerticalAxisDefinition *)definition subchartModel:(CESubchartModel *)subchartModel NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) CEVerticalAxisDefinition *definition;
@property (nonatomic, readonly, weak, nullable) CESubchartModel *subchartModel;

@end

NS_ASSUME_NONNULL_END

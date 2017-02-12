//
//  CEColorScheme.h
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
 Abstract color scheme class. Concrete color scheme behavior is defined in specific subclasses.
 Color scheme determines how drawings and legend items are colored.
 */
@interface CEColorScheme : NSObject<NSCoding>

@end

NS_ASSUME_NONNULL_END

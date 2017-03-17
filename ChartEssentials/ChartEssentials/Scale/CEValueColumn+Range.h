//
//  CEValueColumn+Range.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#include "CEValueRange.h"
#import <ChartEssentials/CEValueColumn.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEValueColumn (ValueRange)

- (void)addValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange;

@end
                                                      
NS_ASSUME_NONNULL_END

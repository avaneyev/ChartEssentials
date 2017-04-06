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

/**
 Private category of a value column used to efficiently determine the range of data in a given column.
 Methods of the category take in a range in a column and a value range object, 
 and pass all the values in the requested range as normal values, high-only or low-only.
 */
@interface CEValueColumn (ValueRange)

- (void)addValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange;
- (void)addHighValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange;
- (void)addLowValuesInRange:(NSRange)range toValueRange:(CEValueRange *)valueRange;

@end
                                                      
NS_ASSUME_NONNULL_END

//
//  CEValueColumn+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEValueColumn.h>

@class CEDateIndexedTable;

@interface CEValueColumn ()

@property (nonatomic, weak, setter=_setTable:) CEDateIndexedTable *_table;

@end

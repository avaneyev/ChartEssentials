//
//  CEDateColumn+Private.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateColumn.h>

@class CEDateIndexedTable;

@interface CEDateColumn ()

@property (nonatomic, weak, setter=_setTable:) CEDateIndexedTable *_table;

@end

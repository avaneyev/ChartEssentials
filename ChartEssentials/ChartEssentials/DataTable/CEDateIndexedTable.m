//
//  CEDateIndexedTable.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDateIndexedTable.h>
#import <ChartEssentials/CEDateColumn.h>
#import <ChartEssentials/CETools.h>
#import <ChartEssentials/CEValueColumn.h>
#import "CEDateColumn+Private.h"
#import "CEValueColumn+Private.h"

@implementation CEDateIndexedTable
{
    CEDateColumn *_dateColumn;
    NSDictionary<NSString *, CEValueColumn *> *_valueColumns;
}

- (instancetype)initWithDateColumn:(CEDateColumn *)dateColumn valueColumns:(NSDictionary<NSString *,CEValueColumn *> *)valueColumns
{
    if (dateColumn == nil) THROW_INVALID_PARAM(dateColumn, nil);
    if (valueColumns.count == 0) THROW_INVALID_PARAM(valueColumns, nil);
    
    if (self = [super init])
    {
        _dateColumn = dateColumn;
        _valueColumns = [valueColumns copy];

#ifdef DEBUG
        CEAssert(dateColumn._table == nil);
        NSUInteger indexCount = dateColumn.count;
#endif
        
        _dateColumn._table = self;
        
        for (NSString *key in valueColumns)
        {
            CEValueColumn *valueColumn = valueColumns[key];
            valueColumn._table = self;
            
            CEAssert(valueColumn.count == indexCount);
        }
    }
    return self;
}

@synthesize dateColumn = _dateColumn;

- (NSSet<NSString *> *)valueColumnNames
{
    return [NSSet setWithArray:_valueColumns.allKeys];
}

- (CEValueColumn *)columnForName:(NSString *)name
{
    return _valueColumns[name];
}

@end

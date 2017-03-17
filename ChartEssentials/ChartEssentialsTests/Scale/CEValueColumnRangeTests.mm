//
//  CEValueColumnRangeTests.mm
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEValueColumn.h>
#import "CEValueColumn+Range.h"

@interface CEValueColumnRangeTests : XCTestCase
@end

@implementation CEValueColumnRangeTests
{
    CEValueRange *_valueRange;
    CEValueColumn *_column;
}

- (void)setUp
{
    _valueRange = new CEValueRange();
    _column = [[CEValueColumn alloc] initWithChunkLength:5];
    CGFloat values[] = { 32, 105, 77, 201, 200, 201, 1357, 19, 19, 33, 101, 200, 500, 17, 14 };
    [_column addValues:values count:(sizeof(values) / sizeof(CGFloat))];
}

- (void)tearDown
{
    delete _valueRange;
}

- (void)testAddEmptyRange
{
    [_column addValuesInRange:NSMakeRange(12, 0) toValueRange:_valueRange];
    XCTAssertTrue(_valueRange->isEmpty());
}

- (void)testAddTrivialRange
{
    [_column addValuesInRange:NSMakeRange(9, 1) toValueRange:_valueRange];
    XCTAssertFalse(_valueRange->isEmpty());
    XCTAssertEqual(_valueRange->high(), 33);
    XCTAssertEqual(_valueRange->low(), 33);
}

- (void)testAddWholeColumn
{
    [_column addValuesInRange:NSMakeRange(0, _column.count) toValueRange:_valueRange];
    XCTAssertFalse(_valueRange->isEmpty());
    XCTAssertEqual(_valueRange->high(), 1357);
    XCTAssertEqual(_valueRange->low(), 14);
}

- (void)testAddPartsOfColumn
{
    [_column addValuesInRange:NSMakeRange(2, _column.count - 4) toValueRange:_valueRange];
    XCTAssertFalse(_valueRange->isEmpty());
    XCTAssertEqual(_valueRange->high(), 1357);
    XCTAssertEqual(_valueRange->low(), 19);
}

@end

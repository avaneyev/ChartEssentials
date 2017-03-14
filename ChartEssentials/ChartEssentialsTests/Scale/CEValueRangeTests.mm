//
//  CEValueRangeTests.mm
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#include "CEValueRange.h"

@interface CEValueRangeTests : XCTestCase

@end

@implementation CEValueRangeTests

- (void)testEmptyRange
{
    CEValueRange emptyRange;
    XCTAssertTrue(emptyRange.isEmpty());
}

- (void)testPredefinedRange
{
    CEValueRange predefinedRange(31, 55);
    XCTAssertFalse(predefinedRange.isEmpty());
    XCTAssertEqual(predefinedRange.high(), 55);
    XCTAssertEqual(predefinedRange.low(), 31);
}

- (void)testAddSingleValues
{
    CEValueRange initiallyEmpty;
    
    initiallyEmpty.addValue(44);
    XCTAssertEqual(initiallyEmpty.low(), 44);
    XCTAssertEqual(initiallyEmpty.high(), 44);
    XCTAssertFalse(initiallyEmpty.isEmpty());
    
    initiallyEmpty.addValue(75);
    XCTAssertEqual(initiallyEmpty.low(), 44);
    XCTAssertEqual(initiallyEmpty.high(), 75);
    
    initiallyEmpty.addValue(70);
    XCTAssertEqual(initiallyEmpty.low(), 44);
    XCTAssertEqual(initiallyEmpty.high(), 75);
    
    initiallyEmpty.addValue(14);
    XCTAssertEqual(initiallyEmpty.low(), 14);
    XCTAssertEqual(initiallyEmpty.high(), 75);
    XCTAssertFalse(initiallyEmpty.isEmpty());
    
    CEValueRange initiallyPredefined(55, 57);
    
    initiallyPredefined.addValue(56);
    XCTAssertEqual(initiallyPredefined.low(), 55);
    XCTAssertEqual(initiallyPredefined.high(), 57);
    XCTAssertFalse(initiallyPredefined.isEmpty());

    initiallyPredefined.addValue(76);
    XCTAssertEqual(initiallyPredefined.low(), 55);
    XCTAssertEqual(initiallyPredefined.high(), 76);
    XCTAssertFalse(initiallyPredefined.isEmpty());

    initiallyPredefined.addValue(32);
    XCTAssertEqual(initiallyPredefined.low(), 32);
    XCTAssertEqual(initiallyPredefined.high(), 76);
    XCTAssertFalse(initiallyPredefined.isEmpty());
}

- (void)testAddLowAndHighSeparately
{
    CEValueRange initiallyEmpty;
    
    initiallyEmpty.addLowValue(33);
    initiallyEmpty.addLowValue(42);
    initiallyEmpty.addLowValue(17);
    initiallyEmpty.addLowValue(88);
    
    initiallyEmpty.addHighValue(15);
    initiallyEmpty.addHighValue(92);
    initiallyEmpty.addHighValue(33);
    initiallyEmpty.addHighValue(77);

    XCTAssertEqual(initiallyEmpty.low(), 17);
    XCTAssertEqual(initiallyEmpty.high(), 92);
    XCTAssertFalse(initiallyEmpty.isEmpty());
}

- (void)testAddArrayOfValues
{
    const CGFloat arrayOfValues[] = { 95, 17, 102, 103, 77, 33, 82, 55, 100, 17, 89, 15 };
    const size_t arraySize = sizeof(arrayOfValues) / sizeof(CGFloat);
    
    CEValueRange initiallyEmpty;
    
    initiallyEmpty.addValues(arrayOfValues, arraySize);
    XCTAssertEqual(initiallyEmpty.low(), 15);
    XCTAssertEqual(initiallyEmpty.high(), 103);
    XCTAssertFalse(initiallyEmpty.isEmpty());
    
    CEValueRange initiallyNotCovering(57, 58);
    initiallyNotCovering.addValues(arrayOfValues, arraySize);
    XCTAssertEqual(initiallyNotCovering.low(), 15);
    XCTAssertEqual(initiallyNotCovering.high(), 103);
    XCTAssertFalse(initiallyNotCovering.isEmpty());
    
    CEValueRange initiallyCoveringLow(10, 40);
    initiallyCoveringLow.addValues(arrayOfValues, arraySize);
    XCTAssertEqual(initiallyCoveringLow.low(), 10);
    XCTAssertEqual(initiallyCoveringLow.high(), 103);
    XCTAssertFalse(initiallyCoveringLow.isEmpty());

    CEValueRange initiallyCoveringHigh(79, 125);
    initiallyCoveringHigh.addValues(arrayOfValues, arraySize);
    XCTAssertEqual(initiallyCoveringHigh.low(), 15);
    XCTAssertEqual(initiallyCoveringHigh.high(), 125);
    XCTAssertFalse(initiallyCoveringHigh.isEmpty());

    CEValueRange initiallyCoveringAll(8, 107);
    initiallyCoveringAll.addValues(arrayOfValues, arraySize);
    XCTAssertEqual(initiallyCoveringAll.low(), 8);
    XCTAssertEqual(initiallyCoveringAll.high(), 107);
    XCTAssertFalse(initiallyCoveringAll.isEmpty());
}

- (void)testAddAraysOfHighsAndLows
{
    const CGFloat arrayOfHighs[] = { 18, 771, 438, 45, 103, 56 };
    const size_t highsSize = sizeof(arrayOfHighs) / sizeof(CGFloat);
    
    const CGFloat arrayOfLows[] = { 355, 14, 87, 215, 49, 14, 15, 16, 14, 144 };
    const size_t lowsSize = sizeof(arrayOfLows) / sizeof(CGFloat);

    CEValueRange initiallyEmpty;
    initiallyEmpty.addHighValues(arrayOfHighs, highsSize);
    initiallyEmpty.addLowValues(arrayOfLows, lowsSize);
    XCTAssertEqual(initiallyEmpty.low(), 14);
    XCTAssertEqual(initiallyEmpty.high(), 771);
    XCTAssertFalse(initiallyEmpty.isEmpty());
    
    CEValueRange initiallySomething(34, 533);
    initiallySomething.addHighValues(arrayOfHighs, highsSize);
    initiallySomething.addLowValues(arrayOfLows, lowsSize);
    XCTAssertEqual(initiallySomething.low(), 14);
    XCTAssertEqual(initiallySomething.high(), 771);
    XCTAssertFalse(initiallySomething.isEmpty());
}

@end

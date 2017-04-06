//
//  CELinearValueScaleTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CELinearValueScale.h>
#import <ChartEssentials/CEScaleHint.h>

@interface CELinearValueScaleTests : XCTestCase
@end

@implementation CELinearValueScaleTests

- (void)testInitialValues
{
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:1015 high:1172 renderHeight:800 hints:nil];
    
    XCTAssertEqual(scale.valueRangeLow, 1015);
    XCTAssertEqual(scale.valueRangeHigh, 1172);
    XCTAssertEqual(scale.renderHeight, 800);
    XCTAssertNil(scale.hints);
}

- (void)testCalculateLinearScaleRange
{
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:1015 high:1172 renderHeight:800 hints:nil];

    XCTAssertEqualWithAccuracy(scale.scaleLow, 1010, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 1190, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"1010" value:1010],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1040" value:1040],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1070" value:1070],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1100" value:1100],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1130" value:1130],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1160" value:1160],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1190" value:1190]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

- (void)testCalculateLinearScaleWithNegativeLowerBound
{
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:-115 high:35 renderHeight:800 hints:nil];
    
    XCTAssertEqualWithAccuracy(scale.scaleLow, -120, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 40, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"-120" value:-120],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-100" value:-100],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-80" value:-80],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-60" value:-60],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-40" value:-40],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-20" value:-20],
                                                 [[CEAxisMarker alloc] initWithCaption:@"0" value:0],
                                                 [[CEAxisMarker alloc] initWithCaption:@"20" value:20],
                                                 [[CEAxisMarker alloc] initWithCaption:@"40" value:40]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

- (void)testCalculateLinearScaleWithLargeValueSpan
{
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:101 high:999 renderHeight:800 hints:nil];

    // There are a few ways [100, 1000] can be partitioned, linear scale favors fewer ranges, so
    // [100, 280, 460,...] is picked over [100, 200, 300, 400,...] and [100, 190, 280, ...].
    XCTAssertEqualWithAccuracy(scale.scaleLow, 100, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 1000, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"100" value:100],
                                                 [[CEAxisMarker alloc] initWithCaption:@"280" value:280],
                                                 [[CEAxisMarker alloc] initWithCaption:@"460" value:460],
                                                 [[CEAxisMarker alloc] initWithCaption:@"640" value:640],
                                                 [[CEAxisMarker alloc] initWithCaption:@"820" value:820],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000" value:1000]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

- (void)testCalculateLinearScaleWithSmallRelativeSpan
{
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:1000001 high:1000010 renderHeight:800 hints:nil];
    XCTAssertEqualWithAccuracy(scale.scaleLow, 1000001, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 1000011, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000001" value:1000001],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000003" value:1000003],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000005" value:1000005],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000007" value:1000007],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000009" value:1000009],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000011" value:1000011]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

- (void)testCalculateLinearScaleWithHintInRange
{
    CEScaleHint *hintZero = [[CEScaleHint alloc] initWithValue:0 kind:CEScaleHintIncludeValueInRangeKey context:nil];
    
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:-115 high:35 renderHeight:800 hints:@[ hintZero ]];
    
    XCTAssertEqualWithAccuracy(scale.scaleLow, -120, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 40, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"-120" value:-120],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-100" value:-100],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-80" value:-80],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-60" value:-60],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-40" value:-40],
                                                 [[CEAxisMarker alloc] initWithCaption:@"-20" value:-20],
                                                 [[CEAxisMarker alloc] initWithCaption:@"0" value:0],
                                                 [[CEAxisMarker alloc] initWithCaption:@"20" value:20],
                                                 [[CEAxisMarker alloc] initWithCaption:@"40" value:40]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

- (void)testCalculateLinearScaleWithHintOutOfRange
{
    CEScaleHint *hintZero = [[CEScaleHint alloc] initWithValue:0 kind:CEScaleHintIncludeValueInRangeKey context:nil];
    
    CELinearValueScale *scale = [[CELinearValueScale alloc] initWithValueRangeLow:101 high:999 renderHeight:800 hints:@[ hintZero ]];
    
    XCTAssertEqualWithAccuracy(scale.scaleLow, 0, 0.1);
    XCTAssertEqualWithAccuracy(scale.scaleHigh, 1000, 0.1);
    
    NSArray<CEAxisMarker *> *expectedMarkers = @[
                                                 [[CEAxisMarker alloc] initWithCaption:@"0" value:0],
                                                 [[CEAxisMarker alloc] initWithCaption:@"200" value:200],
                                                 [[CEAxisMarker alloc] initWithCaption:@"400" value:400],
                                                 [[CEAxisMarker alloc] initWithCaption:@"600" value:600],
                                                 [[CEAxisMarker alloc] initWithCaption:@"800" value:800],
                                                 [[CEAxisMarker alloc] initWithCaption:@"1000" value:1000]
                                                 ];
    XCTAssertEqualObjects(scale.markers, expectedMarkers);
}

@end

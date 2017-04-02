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

@end

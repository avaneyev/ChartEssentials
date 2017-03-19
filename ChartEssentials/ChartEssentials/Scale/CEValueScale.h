//
//  CEValueScale.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An axis marker object stored the data for an axis marker.
 Axis markers are returned by scale so that axis can determine where and how to draw them.
 */
__attribute__((objc_subclassing_restricted))
@interface CEAxisMarker : NSObject<NSCopying>

- (instancetype)initWithCaption:(NSString *)caption value:(CGFloat)value NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) NSString *caption;
@property (nonatomic, readonly) CGFloat value;

@end

@class CEScaleHint;

/**
 Value scale is a model object that defines how data will be scaled for rendering given:
 - Data range (low and high values of the data being rendered);
 - Visual height in screen points;
 - Hints (see CEScaleHint class for detailed description).
 
 Depending on these parameters:
 - Values may be scaled linearly, logarithmically or any other way.
 - Scale may want to show more or fewer axis markers.
 
 CEValueScale is an abstract class that defines an interface for value scale model.
 To provide a custom scale, a concrete subclass must be provided, otherwise default linear scale is used.
 */
@interface CEValueScale : NSObject

- (instancetype)initWithValueRangeLow:(CGFloat)low high:(CGFloat)high renderHeight:(CGFloat)renderHeight hints:(NSArray<CEScaleHint *> * _Nullable)hints NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

// Stores the low value of the actual data range
@property (nonatomic, readonly) CGFloat valueRangeLow;
// Stores the high value of the actual data range
@property (nonatomic, readonly) CGFloat valueRangeHigh;

// Stores the lower scale range value. May be the same or different from the value range low value.
// Subclasses must provide a getter for this property.
@property (nonatomic, readonly) CGFloat scaleLow;
// Stores the higher scale range value. May be the same or different from the value range high value.
// Subclasses must provide a getter for this property.
@property (nonatomic, readonly) CGFloat scaleHigh;

// Stores the render height for the data that is being scaled.
// Height may be updated by the chart if the whole chart or its subcharts are resized.
// A subclass may override the setter if it wants to update the scale properties (such as markers or scale range)
// when height changes.
@property (nonatomic, readwrite) CGFloat renderHeight;

// An array of axis markers corresponding to the scale.
// A subclass must provide a getter for this property.
@property (nonatomic, readonly) NSArray<CEAxisMarker *> *markers;

// Stores an optional array of scale hints.
@property (nonatomic, readonly, nullable) NSArray<CEScaleHint *> *hints;

@end

NS_ASSUME_NONNULL_END

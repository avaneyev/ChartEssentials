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

- (instancetype)initWithCaption:(NSString *)caption value:(CGFloat)value;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) NSString *caption;
@property (nonatomic, readonly) CGFloat value;

@end

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
 All methods and properties of the class except for those storing values passed to the initializer are abstract
 and a subclass must provide implementations for all of them.
 */
@interface CEValueScale : NSObject

@end

NS_ASSUME_NONNULL_END

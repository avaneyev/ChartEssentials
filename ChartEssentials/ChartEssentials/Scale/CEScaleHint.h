//
//  CEScaleHint.h
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
 Scale hints help scale and present the data in a way that makes most sense to a user.
 Hints may be something like:
 - Include a value (for example, 0) in the scale no matter if it's in the data range or not;
 - Draw a marker at a particular point (for example, 10% and 90% bands);
 and so on.
 */
__attribute__((objc_subclassing_restricted))
@interface CEScaleHint : NSObject<NSCoding, NSCopying>

- (instancetype)initWithValue:(CGFloat)value kind:(NSString *)kind context:(id<NSCopying> _Nullable)context NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;
@property (nonatomic, readonly) NSString *kind;
@property (nonatomic, readonly, nullable) id<NSCopying> context;

@end

NS_ASSUME_NONNULL_END

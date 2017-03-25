//
//  CEScaleHint.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEScaleHint.h>
#import <ChartEssentials/CETools.h>

NSString * const CEScaleHintIncludeValueInRangeKey = @"CEScaleHintIncludeValueInRange";

@implementation CEScaleHint

- (instancetype)initWithValue:(CGFloat)value kind:(NSString *)kind context:(id<NSCopying>)context
{
    CEAlwaysAssert(kind != nil);
    
    if (self = [super init])
    {
        _value = value;
        _kind = [kind copy];
        _context = [context copyWithZone:NULL];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        // TODO: decode object contents
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // TODO: encode object contents
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[CEScaleHint alloc] initWithValue:_value kind:_kind context:_context];
}

@synthesize value = _value;
@synthesize kind = _kind;
@synthesize context = _context;

@end

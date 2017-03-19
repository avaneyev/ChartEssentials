//
//  CEValueScale.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEValueScale.h>

@implementation CEAxisMarker
{
    NSString *_caption;
    CGFloat _value;
}

- (instancetype)initWithCaption:(NSString *)caption value:(CGFloat)value
{
    if (self = [super init])
    {
        _caption = [caption copy];
        _value = value;
    }
    return self;
}

@synthesize caption = _caption;
@synthesize value = _value;

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end

@implementation CEValueScale

@end

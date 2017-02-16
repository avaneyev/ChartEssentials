//
//  CEColorScheme.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEColorScheme.h>
#import <ChartEssentials/CETools.h>
#import "CEColorScheme+Private.h"

@implementation CEColorScheme

- (instancetype)init
{
    return [super init];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    // subclasses will override
    self = [super init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // subclasses will override
}

- (CEImage *)_drawSchemeWithMask:(CEImage *)mask
{
    THROW_ABSTRACT(nil);
}

- (void)_drawSchemeInContext:(CGContextRef)context rect:(CGRect)rect
{
    THROW_ABSTRACT(nil);
}

@end
